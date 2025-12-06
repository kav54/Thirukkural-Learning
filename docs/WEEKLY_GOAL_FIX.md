# 🐛 Weekly Goal Fix

## 📝 Issue
The user reported that the "Weekly Goal" banner on the home screen was not updating after completing daily challenges (specifically "Fill in the Blanks").

## 🔍 Root Cause
The weekly goal text in `HomeDashboardPage` was hardcoded to `'0/3 days'` and was not connected to any data source. Additionally, the `StreakService` was not tracking weekly progress.

## 🛠️ Fix Implemented

### **1. StreakService Update**
- Added `_weeklyVisitsKey` and `_weekStartDateKey` to `SharedPreferences`.
- Implemented `getWeeklyProgress()` to return the number of days visited this week.
- Updated `updateStreak()` to automatically track weekly visits:
  - Resets count to 1 on Mondays (new week).
  - Increments count on new daily visits.

### **2. HomeDashboardPage Update**
- Added `_weeklyProgress` state variable.
- Fetch `weeklyProgress` from `StreakService` during initialization.
- Updated `_buildWeeklyGoalBanner` to display the dynamic value: `'$_weeklyProgress/3 days'`.

## ✅ Verification
- When the app opens, it updates the streak and weekly progress.
- If it's the first visit of the day, the weekly count increments.
- The home screen banner now shows the correct count (e.g., "1/3 days").

**The weekly goal is now fully functional and tracks user activity!** 🎯
