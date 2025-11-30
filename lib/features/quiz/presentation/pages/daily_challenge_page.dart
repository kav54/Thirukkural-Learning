import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyChallengePage extends StatelessWidget {
  const DailyChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: _buildGamesGrid(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 10),
          Text(
            '🎯 Daily Challenge',
            style: GoogleFonts.catamaran(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGamesGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(20),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildGameCard(
          context,
          'Word Puzzle',
          '~2 mins',
          Icons.extension,
          const LinearGradient(
            colors: [Color(0xFFF97316), Color(0xFFEA580C)],
          ),
          true, // Pulse effect
        ).animate().fadeIn(delay: 100.ms).scale(),
        
        _buildGameCard(
          context,
          'Fill Blanks',
          '~1 mins',
          Icons.edit_square,
          const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
          ),
          false,
        ).animate().fadeIn(delay: 200.ms).scale(),
        
        _buildGameCard(
          context,
          'Match Pairs',
          '~3 mins',
          Icons.grid_view,
          const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF059669)],
          ),
          false,
        ).animate().fadeIn(delay: 300.ms).scale(),
        
        _buildGameCard(
          context,
          'True or False',
          '~2 mins',
          Icons.check_circle_outline,
          const LinearGradient(
            colors: [Color(0xFFEC4899), Color(0xFFDB2777)],
          ),
          false,
        ).animate().fadeIn(delay: 400.ms).scale(),
      ],
    );
  }

  Widget _buildGameCard(
    BuildContext context,
    String title,
    String duration,
    IconData icon,
    Gradient gradient,
    bool hasPulse,
  ) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title - Coming Soon!'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.white,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  duration,
                  style: GoogleFonts.quicksand(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
