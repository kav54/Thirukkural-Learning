import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/quiz.dart';
import '../bloc/quiz_bloc.dart';
import 'quiz_results_page.dart';

class FillBlanksQuizPage extends StatelessWidget {
  final List<QuizQuestion> questions;

  const FillBlanksQuizPage({
    super.key,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc()..add(StartQuizEvent(questions)),
      child: const _FillBlanksQuizView(),
    );
  }
}

class _FillBlanksQuizView extends StatelessWidget {
  const _FillBlanksQuizView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: BlocConsumer<QuizBloc, QuizState>(
          listener: (context, state) {
            if (state is QuizCompleted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizResultsPage(session: state.session),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is QuizInProgress) {
              return _buildQuizContent(context, state);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildQuizContent(BuildContext context, QuizInProgress state) {
    final session = state.session;
    final question = session.currentQuestion;
    final progress = (session.currentQuestionIndex + 1) / session.totalQuestions;

    return Column(
      children: [
        _buildHeader(context, session),
        _buildProgressBar(progress),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestionCard(question),
                const SizedBox(height: 24),
                _buildOptions(context, question, state),
                if (state.showFeedback) ...[
                  const SizedBox(height: 24),
                  _buildFeedback(context, state, question),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, QuizSession session) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => _showExitDialog(context),
              ),
              const SizedBox(width: 8),
              Text(
                'Question ${session.currentQuestionIndex + 1}/${session.totalQuestions}',
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E8FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '⭐ ${session.score}',
              style: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF8B5CF6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Container(
      height: 4,
      color: const Color(0xFFE2E8F0),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
            ),
          ),
        ),
      ),
    ).animate().fadeIn();
  }

  Widget _buildQuestionCard(QuizQuestion question) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Kural #${question.kuralNumber}',
              style: GoogleFonts.quicksand(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFF59E0B),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            question.question,
            style: GoogleFonts.catamaran(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
              height: 1.6,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().scale();
  }

  Widget _buildOptions(BuildContext context, QuizQuestion question, QuizInProgress state) {
    return Column(
      children: question.options.map((option) {
        final isSelected = state.session.userAnswers[state.session.currentQuestionIndex] == option;
        final isCorrect = option == question.correctAnswer;
        
        Color? backgroundColor;
        Color? borderColor;
        
        if (state.showFeedback) {
          if (isSelected) {
            backgroundColor = isCorrect 
                ? const Color(0xFFD1FAE5) 
                : const Color(0xFFFEE2E2);
            borderColor = isCorrect 
                ? const Color(0xFF10B981) 
                : const Color(0xFFEF4444);
          } else if (isCorrect) {
            backgroundColor = const Color(0xFFD1FAE5);
            borderColor = const Color(0xFF10B981);
          }
        } else if (isSelected) {
          backgroundColor = const Color(0xFFF3E8FF);
          borderColor = const Color(0xFF8B5CF6);
        }

        return GestureDetector(
          onTap: state.showFeedback 
              ? null 
              : () => context.read<QuizBloc>().add(AnswerQuestionEvent(option)),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: borderColor ?? const Color(0xFFE2E8F0),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option,
                    style: GoogleFonts.catamaran(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ),
                if (state.showFeedback && isCorrect)
                  const Icon(Icons.check_circle, color: Color(0xFF10B981)),
                if (state.showFeedback && isSelected && !isCorrect)
                  const Icon(Icons.cancel, color: Color(0xFFEF4444)),
              ],
            ),
          ),
        ).animate().fadeIn(delay: (question.options.indexOf(option) * 100).ms);
      }).toList(),
    );
  }

  Widget _buildFeedback(BuildContext context, QuizInProgress state, QuizQuestion question) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: state.isCorrect 
                ? const Color(0xFFD1FAE5) 
                : const Color(0xFFFEE2E2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    state.isCorrect ? Icons.check_circle : Icons.cancel,
                    color: state.isCorrect 
                        ? const Color(0xFF10B981) 
                        : const Color(0xFFEF4444),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      state.isCorrect ? 'Correct! Well done!' : 'Incorrect. The correct answer is: ${question.correctAnswer}',
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ),
                ],
              ),
              if (question.hint != null) ...[
                const SizedBox(height: 12),
                Text(
                  'Meaning: ${question.hint}',
                  style: GoogleFonts.quicksand(
                    fontSize: 13,
                    color: const Color(0xFF64748B),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => context.read<QuizBloc>().add(NextQuestionEvent()),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B5CF6),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Continue',
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn();
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Exit Quiz?',
          style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Your progress will be lost.',
          style: GoogleFonts.quicksand(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: GoogleFonts.quicksand()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: Text(
              'Exit',
              style: GoogleFonts.quicksand(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
