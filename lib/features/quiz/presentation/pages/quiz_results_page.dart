import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/quiz.dart';

class QuizResultsPage extends StatelessWidget {
  final QuizSession session;

  const QuizResultsPage({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = session.percentage;
    final isPerfect = percentage == 100;
    final isGood = percentage >= 70;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    _buildResultIcon(isPerfect, isGood),
                    const SizedBox(height: 24),
                    _buildTitle(isPerfect, isGood),
                    const SizedBox(height: 12),
                    _buildSubtitle(isPerfect, isGood),
                    const SizedBox(height: 40),
                    _buildScoreCard(),
                    const SizedBox(height: 24),
                    _buildStats(),
                  ],
                ),
              ),
            ),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildResultIcon(bool isPerfect, bool isGood) {
    String emoji = isPerfect ? '🎉' : isGood ? '😊' : '💪';
    
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: isPerfect 
              ? [const Color(0xFFF59E0B), const Color(0xFFEAB308)]
              : isGood
                  ? [const Color(0xFF10B981), const Color(0xFF059669)]
                  : [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)],
        ),
        boxShadow: [
          BoxShadow(
            color: (isPerfect 
                ? const Color(0xFFF59E0B) 
                : isGood 
                    ? const Color(0xFF10B981) 
                    : const Color(0xFF8B5CF6)
            ).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 60),
        ),
      ),
    ).animate().scale(duration: 600.ms, curve: Curves.elasticOut);
  }

  Widget _buildTitle(bool isPerfect, bool isGood) {
    String title = isPerfect 
        ? 'Perfect Score!' 
        : isGood 
            ? 'Great Job!' 
            : 'Keep Practicing!';
    
    return Text(
      title,
      style: GoogleFonts.catamaran(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF0F172A),
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildSubtitle(bool isPerfect, bool isGood) {
    String subtitle = isPerfect 
        ? 'You\'re a Thirukkural master!' 
        : isGood 
            ? 'You\'re doing really well!' 
            : 'Practice makes perfect!';
    
    return Text(
      subtitle,
      style: GoogleFonts.quicksand(
        fontSize: 16,
        color: const Color(0xFF64748B),
      ),
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildScoreCard() {
    final percentage = session.percentage;
    
    return Container(
      padding: const EdgeInsets.all(32),
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
          Text(
            'Your Score',
            style: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${session.score}/${session.totalQuestions}',
            style: GoogleFonts.catamaran(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${percentage.toStringAsFixed(0)}%',
            style: GoogleFonts.quicksand(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).scale();
  }

  Widget _buildStats() {
    final duration = session.endTime != null 
        ? session.endTime!.difference(session.startTime)
        : Duration.zero;
    
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Questions',
            '${session.totalQuestions}',
            Icons.quiz,
            const Color(0xFF3B82F6),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Time',
            '${minutes}m ${seconds}s',
            Icons.timer,
            const Color(0xFFF59E0B),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 500.ms);
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.catamaran(
              fontSize: 20,
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

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Go back to quiz list
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Back to Quizzes',
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF8B5CF6),
                side: const BorderSide(color: Color(0xFF8B5CF6)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Try Again',
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0);
  }
}
