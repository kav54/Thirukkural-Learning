import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../injection_container.dart' as di;
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/streak_service.dart';
import '../../../kural/data/models/kural_model.dart';
import '../../../onboarding/presentation/pages/auth_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Isar _isar = di.sl<Isar>();
  final AuthService _authService = di.sl<AuthService>();
  final StreakService _streakService = di.sl<StreakService>();
  
  User? _currentUser;
  int _totalKurals = 0;
  int _completedKurals = 0;
  int _currentStreak = 0;

  @override
  void initState() {
    super.initState();
    _currentUser = _authService.currentUser;
    _currentStreak = _streakService.getCurrentStreak();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final total = await _isar.kuralModels.count();
    setState(() {
      _totalKurals = total;
      _completedKurals = (total * 0.15).round(); // Demo: 15% completed
    });
  }

  Future<void> _handleLogout() async {
    try {
      await _authService.signOut();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthPage()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildProfileCard(),
              const SizedBox(height: 24),
              _buildStatsGrid(),
              const SizedBox(height: 24),
              _buildAchievements(),
              const SizedBox(height: 24),
              _buildSettings(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFFF8FAFC),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Profile',
            style: GoogleFonts.quicksand(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildProfileCard() {
    final name = _currentUser?.displayName ?? 'Little Learner';
    final photoUrl = _currentUser?.photoURL;
    final email = _currentUser?.email ?? 'learner@thirukkural.com';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              image: photoUrl != null 
                ? DecorationImage(image: NetworkImage(photoUrl), fit: BoxFit.cover)
                : null,
            ),
            child: photoUrl == null 
              ? const Icon(Icons.person, size: 40, color: Color(0xFF8B5CF6))
              : null,
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: GoogleFonts.catamaran(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: GoogleFonts.quicksand(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Little Learner',
              style: GoogleFonts.quicksand(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProfileStat('🔥', '$_currentStreak', 'Day Streak'),
              Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
              _buildProfileStat('⭐', '120', 'Points'),
              Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
              _buildProfileStat('🏆', '3', 'Badges'),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).scale();
  }

  Widget _buildProfileStat(String emoji, String value, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.catamaran(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: 11,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    final progress = _totalKurals > 0 ? _completedKurals / _totalKurals : 0.0;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Learning Progress',
            style: GoogleFonts.catamaran(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kurals Learned',
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    Text(
                      '$_completedKurals / $_totalKurals',
                      style: GoogleFonts.catamaran(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFE2E8F0),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8B5CF6)),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(progress * 100).toStringAsFixed(1)}% Complete',
                  style: GoogleFonts.quicksand(
                    fontSize: 12,
                    color: const Color(0xFF8B5CF6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Quizzes Taken',
                  '12',
                  Icons.quiz,
                  const Color(0xFF3B82F6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Avg Score',
                  '85%',
                  Icons.trending_up,
                  const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.catamaran(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.quicksand(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Achievements',
            style: GoogleFonts.catamaran(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildAchievementBadge('🎯', 'First Quiz', 'Completed', true),
                const SizedBox(width: 12),
                _buildAchievementBadge('🔥', '5 Day Streak', 'Completed', true),
                const SizedBox(width: 12),
                _buildAchievementBadge('📚', '100 Kurals', 'In Progress', false),
                const SizedBox(width: 12),
                _buildAchievementBadge('⭐', 'Perfect Score', 'Locked', false),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildAchievementBadge(String emoji, String title, String status, bool isUnlocked) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnlocked ? Colors.white : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnlocked ? const Color(0xFFF59E0B) : const Color(0xFFE2E8F0),
          width: isUnlocked ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: TextStyle(
              fontSize: 32,
              color: isUnlocked ? null : Colors.grey.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.quicksand(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isUnlocked ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            status,
            style: GoogleFonts.quicksand(
              fontSize: 10,
              color: isUnlocked ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: GoogleFonts.catamaran(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingItem(Icons.notifications_outlined, 'Notifications', () {}),
          _buildSettingItem(Icons.language_outlined, 'Language', () {}),
          _buildSettingItem(Icons.dark_mode_outlined, 'Dark Mode', () {}),
          _buildSettingItem(Icons.help_outline, 'Help & Support', () {}),
          _buildSettingItem(Icons.info_outline, 'About', () {}),
          _buildSettingItem(Icons.logout, 'Logout', _handleLogout, isDestructive: true),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildSettingItem(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red : const Color(0xFF64748B),
        ),
        title: Text(
          title,
          style: GoogleFonts.quicksand(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isDestructive ? Colors.red : const Color(0xFF1E293B),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: isDestructive ? Colors.red : const Color(0xFF94A3B8),
        ),
        onTap: onTap,
      ),
    );
  }
}
