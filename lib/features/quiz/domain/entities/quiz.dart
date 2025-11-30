import 'package:equatable/equatable.dart';

enum QuizType {
  fillBlanks,
  wordPuzzle,
  matchPairs,
  trueOrFalse,
}

class QuizQuestion extends Equatable {
  final int id;
  final QuizType type;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String? hint;
  final int kuralNumber;

  const QuizQuestion({
    required this.id,
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.hint,
    required this.kuralNumber,
  });

  @override
  List<Object?> get props => [id, type, question, options, correctAnswer, hint, kuralNumber];
}

class QuizSession extends Equatable {
  final List<QuizQuestion> questions;
  final int currentQuestionIndex;
  final Map<int, String> userAnswers;
  final int score;
  final DateTime startTime;
  final DateTime? endTime;

  const QuizSession({
    required this.questions,
    this.currentQuestionIndex = 0,
    this.userAnswers = const {},
    this.score = 0,
    required this.startTime,
    this.endTime,
  });

  bool get isCompleted => currentQuestionIndex >= questions.length;
  
  QuizQuestion get currentQuestion => questions[currentQuestionIndex];
  
  int get totalQuestions => questions.length;
  
  int get answeredQuestions => userAnswers.length;
  
  double get percentage => (score / totalQuestions) * 100;

  QuizSession copyWith({
    List<QuizQuestion>? questions,
    int? currentQuestionIndex,
    Map<int, String>? userAnswers,
    int? score,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return QuizSession(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      userAnswers: userAnswers ?? this.userAnswers,
      score: score ?? this.score,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  List<Object?> get props => [
        questions,
        currentQuestionIndex,
        userAnswers,
        score,
        startTime,
        endTime,
      ];
}
