import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/quiz.dart';

// Events
abstract class QuizEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartQuizEvent extends QuizEvent {
  final List<QuizQuestion> questions;

  StartQuizEvent(this.questions);

  @override
  List<Object?> get props => [questions];
}

class AnswerQuestionEvent extends QuizEvent {
  final String answer;

  AnswerQuestionEvent(this.answer);

  @override
  List<Object?> get props => [answer];
}

class NextQuestionEvent extends QuizEvent {}

class CompleteQuizEvent extends QuizEvent {}

// States
abstract class QuizState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizInProgress extends QuizState {
  final QuizSession session;
  final bool showFeedback;
  final bool isCorrect;

  QuizInProgress({
    required this.session,
    this.showFeedback = false,
    this.isCorrect = false,
  });

  @override
  List<Object?> get props => [session, showFeedback, isCorrect];
}

class QuizCompleted extends QuizState {
  final QuizSession session;

  QuizCompleted(this.session);

  @override
  List<Object?> get props => [session];
}

// BLoC
class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    on<StartQuizEvent>(_onStartQuiz);
    on<AnswerQuestionEvent>(_onAnswerQuestion);
    on<NextQuestionEvent>(_onNextQuestion);
    on<CompleteQuizEvent>(_onCompleteQuiz);
  }

  void _onStartQuiz(StartQuizEvent event, Emitter<QuizState> emit) {
    final session = QuizSession(
      questions: event.questions,
      startTime: DateTime.now(),
    );
    emit(QuizInProgress(session: session));
  }

  void _onAnswerQuestion(AnswerQuestionEvent event, Emitter<QuizState> emit) {
    if (state is QuizInProgress) {
      final currentState = state as QuizInProgress;
      final session = currentState.session;
      final currentQuestion = session.currentQuestion;
      
      final isCorrect = event.answer == currentQuestion.correctAnswer;
      
      final updatedAnswers = Map<int, String>.from(session.userAnswers);
      updatedAnswers[session.currentQuestionIndex] = event.answer;
      
      final updatedScore = isCorrect ? session.score + 1 : session.score;
      
      final updatedSession = session.copyWith(
        userAnswers: updatedAnswers,
        score: updatedScore,
      );
      
      emit(QuizInProgress(
        session: updatedSession,
        showFeedback: true,
        isCorrect: isCorrect,
      ));
    }
  }

  void _onNextQuestion(NextQuestionEvent event, Emitter<QuizState> emit) {
    if (state is QuizInProgress) {
      final currentState = state as QuizInProgress;
      final session = currentState.session;
      
      final nextIndex = session.currentQuestionIndex + 1;
      
      if (nextIndex >= session.questions.length) {
        // Quiz completed
        final completedSession = session.copyWith(
          currentQuestionIndex: nextIndex,
          endTime: DateTime.now(),
        );
        emit(QuizCompleted(completedSession));
      } else {
        // Move to next question
        final updatedSession = session.copyWith(
          currentQuestionIndex: nextIndex,
        );
        emit(QuizInProgress(session: updatedSession));
      }
    }
  }

  void _onCompleteQuiz(CompleteQuizEvent event, Emitter<QuizState> emit) {
    if (state is QuizInProgress) {
      final currentState = state as QuizInProgress;
      final completedSession = currentState.session.copyWith(
        endTime: DateTime.now(),
      );
      emit(QuizCompleted(completedSession));
    }
  }
}
