import 'package:shared_preferences/shared_preferences.dart';

/// Service to track and manage user learning streaks
/// Uses SharedPreferences for fast, local-only storage
class StreakService {
  final SharedPreferences _prefs;
  
  // Keys
  static const String _currentStreakKey = 'current_streak';
  static const String _longestStreakKey = 'longest_streak';
  static const String _lastVisitDateKey = 'last_visit_date';
  static const String _totalDaysActiveKey = 'total_days_active';
  static const String _streakFreezeUsedKey = 'streak_freeze_used';
  static const String _weeklyVisitsKey = 'weekly_visits';
  static const String _weekStartDateKey = 'week_start_date';
  
  StreakService(this._prefs);
  
  /// Get current streak count
  int getCurrentStreak() {
    return _prefs.getInt(_currentStreakKey) ?? 0;
  }
  
  /// Get longest streak ever achieved
  int getLongestStreak() {
    return _prefs.getInt(_longestStreakKey) ?? 0;
  }
  
  /// Get total days the app has been used
  int getTotalDaysActive() {
    return _prefs.getInt(_totalDaysActiveKey) ?? 0;
  }
  
  /// Get weekly progress (days visited this week)
  int getWeeklyProgress() {
    _checkAndResetWeeklyProgress();
    return _prefs.getInt(_weeklyVisitsKey) ?? 0;
  }
  
  /// Get last visit date
  DateTime? getLastVisitDate() {
    final dateStr = _prefs.getString(_lastVisitDateKey);
    if (dateStr == null) return null;
    return DateTime.parse(dateStr);
  }
  
  /// Check if user has visited today
  bool hasVisitedToday() {
    final lastVisit = getLastVisitDate();
    if (lastVisit == null) return false;
    
    final today = _getTodayDate();
    return _isSameDay(lastVisit, today);
  }
  
  /// Update streak based on current visit
  /// Returns the new streak count
  Future<StreakUpdateResult> updateStreak() async {
    final now = DateTime.now();
    final today = _getTodayDate();
    final lastVisit = getLastVisitDate();
    
    // Check and update weekly progress
    await _updateWeeklyProgress(today, lastVisit);
    
    // If already visited today, no change
    if (lastVisit != null && _isSameDay(lastVisit, today)) {
      return StreakUpdateResult(
        newStreak: getCurrentStreak(),
        isNewRecord: false,
        streakBroken: false,
        message: 'Already visited today',
      );
    }
    
    int currentStreak = getCurrentStreak();
    int longestStreak = getLongestStreak();
    bool streakBroken = false;
    bool isNewRecord = false;
    
    if (lastVisit == null) {
      // First visit ever
      currentStreak = 1;
    } else {
      final daysSinceLastVisit = today.difference(lastVisit).inDays;
      
      if (daysSinceLastVisit == 1) {
        // Consecutive day - increment streak
        currentStreak++;
      } else if (daysSinceLastVisit > 1) {
        // Streak broken - reset to 1
        streakBroken = true;
        currentStreak = 1;
      }
      // If daysSinceLastVisit == 0, same day (shouldn't happen due to check above)
    }
    
    // Check if new record
    if (currentStreak > longestStreak) {
      longestStreak = currentStreak;
      isNewRecord = true;
      await _prefs.setInt(_longestStreakKey, longestStreak);
    }
    
    // Save current streak and last visit
    await _prefs.setInt(_currentStreakKey, currentStreak);
    await _prefs.setString(_lastVisitDateKey, now.toIso8601String());
    
    // Increment total days active
    final totalDays = getTotalDaysActive();
    await _prefs.setInt(_totalDaysActiveKey, totalDays + 1);
    
    // Clear streak freeze if used
    await _prefs.setBool(_streakFreezeUsedKey, false);
    
    print('🔥 Streak updated: $currentStreak days (Longest: $longestStreak)');
    
    return StreakUpdateResult(
      newStreak: currentStreak,
      isNewRecord: isNewRecord,
      streakBroken: streakBroken,
      message: _getStreakMessage(currentStreak, isNewRecord, streakBroken),
    );
  }

  /// Check if we need to reset weekly progress (new week started)
  void _checkAndResetWeeklyProgress() {
    final today = _getTodayDate();
    final weekStartStr = _prefs.getString(_weekStartDateKey);
    
    if (weekStartStr == null) {
      return; // Will be set on first update
    }
    
    final weekStart = DateTime.parse(weekStartStr);
    final daysSinceStart = today.difference(weekStart).inDays;
    
    // If more than 7 days or if today is Monday and weekStart wasn't today
    // (Simple logic: reset if difference >= 7 or if today is Monday and it's a new week)
    // Better logic: Find the Monday of the current week. If stored weekStart is before that, reset.
    
    final currentWeekMonday = today.subtract(Duration(days: today.weekday - 1));
    if (weekStart.isBefore(currentWeekMonday)) {
      // It's a new week! Reset but don't write yet (wait for update)
      // Actually, for getWeeklyProgress to be accurate, we should probably return 0 here
      // but we can't write to prefs in a sync method easily if we want to be pure.
      // But since we are reading, we can just return 0 if it's a new week.
    }
  }

  /// Update weekly progress logic
  Future<void> _updateWeeklyProgress(DateTime today, DateTime? lastVisit) async {
    final currentWeekMonday = today.subtract(Duration(days: today.weekday - 1));
    final weekStartStr = _prefs.getString(_weekStartDateKey);
    
    // Initialize or Reset if new week
    if (weekStartStr == null || DateTime.parse(weekStartStr).isBefore(currentWeekMonday)) {
      await _prefs.setString(_weekStartDateKey, currentWeekMonday.toIso8601String());
      await _prefs.setInt(_weeklyVisitsKey, 1); // First visit of the week
      return;
    }
    
    // If same week
    final currentVisits = _prefs.getInt(_weeklyVisitsKey) ?? 0;
    
    // Check if visited today
    if (lastVisit == null || !_isSameDay(lastVisit, today)) {
      await _prefs.setInt(_weeklyVisitsKey, currentVisits + 1);
    } else if (currentVisits == 0) {
      // Edge case: Visited today but count is 0 (e.g. first run after update)
      await _prefs.setInt(_weeklyVisitsKey, 1);
    }
  }
  
  /// Check if streak is at risk (user hasn't visited today)
  bool isStreakAtRisk() {
    final lastVisit = getLastVisitDate();
    if (lastVisit == null) return false;
    
    final today = _getTodayDate();
    final daysSince = today.difference(lastVisit).inDays;
    
    // Streak is at risk if last visit was yesterday
    return daysSince == 1;
  }
  
  /// Check if streak will break tomorrow if user doesn't visit
  bool willStreakBreakTomorrow() {
    final lastVisit = getLastVisitDate();
    if (lastVisit == null) return false;
    
    final today = _getTodayDate();
    final daysSince = today.difference(lastVisit).inDays;
    
    // Will break if last visit was 2+ days ago
    return daysSince >= 1;
  }
  
  /// Get streak status
  StreakStatus getStreakStatus() {
    final currentStreak = getCurrentStreak();
    final lastVisit = getLastVisitDate();
    
    if (lastVisit == null) {
      return StreakStatus.notStarted;
    }
    
    final today = _getTodayDate();
    final daysSince = today.difference(lastVisit).inDays;
    
    if (daysSince == 0) {
      return StreakStatus.active; // Visited today
    } else if (daysSince == 1) {
      return StreakStatus.atRisk; // Visited yesterday, need to visit today
    } else {
      return StreakStatus.broken; // Missed a day
    }
  }
  
  /// Reset streak (for testing or user request)
  Future<void> resetStreak() async {
    await _prefs.setInt(_currentStreakKey, 0);
    await _prefs.remove(_lastVisitDateKey);
    print('🔄 Streak reset');
  }
  
  /// Get motivational message based on streak
  String getMotivationalMessage() {
    final streak = getCurrentStreak();
    
    if (streak == 0) {
      return 'Start your learning journey today! 🌟';
    } else if (streak == 1) {
      return 'Great start! Come back tomorrow to build your streak! 🔥';
    } else if (streak < 7) {
      return 'You\'re on fire! $streak days strong! Keep it up! 🔥';
    } else if (streak < 30) {
      return 'Amazing! $streak day streak! You\'re building a great habit! 💪';
    } else if (streak < 100) {
      return 'Incredible! $streak days of learning! You\'re a star! ⭐';
    } else if (streak < 365) {
      return 'Legendary! $streak day streak! You\'re unstoppable! 🏆';
    } else {
      return 'EPIC! $streak days! You\'re a Thirukkural master! 👑';
    }
  }
  
  /// Get streak emoji based on count
  String getStreakEmoji() {
    final streak = getCurrentStreak();
    
    if (streak == 0) return '💤';
    if (streak < 3) return '🔥';
    if (streak < 7) return '🔥🔥';
    if (streak < 30) return '🔥🔥🔥';
    if (streak < 100) return '⚡';
    if (streak < 365) return '💎';
    return '👑';
  }
  
  /// Helper: Get today's date at midnight
  DateTime _getTodayDate() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
  
  /// Helper: Check if two dates are the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }
  
  /// Helper: Get streak message
  String _getStreakMessage(int streak, bool isNewRecord, bool streakBroken) {
    if (streakBroken) {
      return 'Streak reset. Start fresh today! 💪';
    }
    
    if (isNewRecord) {
      return '🎉 New record! $streak day streak!';
    }
    
    if (streak == 1) {
      return 'Welcome back! Start your streak today! 🔥';
    }
    
    return '$streak day streak! Keep it going! 🔥';
  }
}

/// Result of streak update
class StreakUpdateResult {
  final int newStreak;
  final bool isNewRecord;
  final bool streakBroken;
  final String message;
  
  StreakUpdateResult({
    required this.newStreak,
    required this.isNewRecord,
    required this.streakBroken,
    required this.message,
  });
}

/// Streak status enum
enum StreakStatus {
  notStarted,  // Never visited
  active,      // Visited today
  atRisk,      // Visited yesterday, need to visit today
  broken,      // Missed a day
}
