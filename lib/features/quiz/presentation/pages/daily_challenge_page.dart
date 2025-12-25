import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/usecases/quiz_generator.dart';
import '../../domain/usecases/wordle_word_generator.dart';
import '../../../../injection_container.dart' as di;
import 'fill_blanks_quiz_page.dart';
import 'wordle_game_page.dart';

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
        ),
        
        _buildGameCard(
          context,
          'Fill Blanks',
          '~1 mins',
          Icons.edit_square,
          const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
          ),
          false,
        ),
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
      onTap: () async {
        if (title == 'Word Puzzle') {
          // Show loading
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
          
          // Generate word pool for Wordle
          final wordGenerator = WordleWordGenerator(di.sl());
          final wordPool = await wordGenerator.generateWordPool();
          
          // If word pool is empty, use curated list
          final finalWordPool = wordPool.isEmpty 
            ? wordGenerator.getCuratedWordList()
            : wordPool;
          
          // Close loading
          if (context.mounted) Navigator.pop(context);
          
          if (finalWordPool.isNotEmpty && context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WordleGamePage(wordPool: finalWordPool),
              ),
            );
          } else if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to generate word pool')),
            );
          }
        } else if (title == 'Fill Blanks') {
          // Show loading
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
          
          // Generate quiz
          final generator = QuizGenerator(di.sl());
          final questions = await generator.generateFillBlanksQuiz(questionCount: 5);
          
          // Close loading
          if (context.mounted) Navigator.pop(context);
          
          if (questions.isNotEmpty && context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FillBlanksQuizPage(questions: questions),
              ),
            );
          } else if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to generate quiz')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title - Coming Soon!'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
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
