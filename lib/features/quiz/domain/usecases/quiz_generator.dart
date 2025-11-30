import 'dart:math';
import 'package:isar/isar.dart';
import '../../../kural/data/models/kural_model.dart';
import '../entities/quiz.dart';

class QuizGenerator {
  final Isar isar;
  final Random _random = Random();

  QuizGenerator(this.isar);

  /// Generate Fill Blanks questions from kurals
  Future<List<QuizQuestion>> generateFillBlanksQuiz({
    int? chapterNumber,
    int questionCount = 5,
  }) async {
    List<KuralModel> kurals;
    
    if (chapterNumber != null) {
      kurals = await isar.kuralModels
          .filter()
          .chapterNumberEqualTo(chapterNumber)
          .findAll();
    } else {
      // Get random kurals
      final allKurals = await isar.kuralModels.where().findAll();
      kurals = (allKurals..shuffle()).take(questionCount).toList();
    }

    if (kurals.isEmpty) return [];

    final questions = <QuizQuestion>[];
    
    for (int i = 0; i < min(questionCount, kurals.length); i++) {
      final kural = kurals[i];
      final question = _createFillBlanksQuestion(kural, i);
      if (question != null) {
        questions.add(question);
      }
    }

    return questions;
  }

  QuizQuestion? _createFillBlanksQuestion(KuralModel kural, int index) {
    // Split the kural into words
    final line1Words = kural.line1Tamil.split(' ');
    final line2Words = kural.line2Tamil.split(' ');
    
    if (line1Words.isEmpty && line2Words.isEmpty) return null;

    // Randomly choose which line to use
    final useLine1 = _random.nextBool() && line1Words.length > 1;
    final words = useLine1 ? line1Words : line2Words;
    
    if (words.length < 2) return null;

    // Choose a random word to blank out (not the first or last)
    final blankIndex = words.length > 3 
        ? _random.nextInt(words.length - 2) + 1
        : _random.nextInt(words.length);
    
    final correctAnswer = words[blankIndex];
    
    // Create the question text with blank
    final questionWords = List<String>.from(words);
    questionWords[blankIndex] = '______';
    final questionText = questionWords.join(' ');

    // Generate wrong options from other kurals
    final options = <String>[correctAnswer];
    
    // Add some similar-length words as distractors
    final allWords = <String>[];
    allWords.addAll(kural.line1Tamil.split(' '));
    allWords.addAll(kural.line2Tamil.split(' '));
    
    // Try to get words of similar length
    final similarWords = allWords.where((w) => 
      w != correctAnswer && 
      (w.length - correctAnswer.length).abs() <= 2
    ).toList();
    
    similarWords.shuffle();
    options.addAll(similarWords.take(3));
    
    // If we don't have enough options, add random words
    while (options.length < 4) {
      final randomWord = allWords[_random.nextInt(allWords.length)];
      if (!options.contains(randomWord)) {
        options.add(randomWord);
      }
    }
    
    options.shuffle();

    return QuizQuestion(
      id: index,
      type: QuizType.fillBlanks,
      question: 'Fill in the blank:\n$questionText',
      options: options.take(4).toList(),
      correctAnswer: correctAnswer,
      hint: kural.meaningEnglish,
      kuralNumber: kural.number,
    );
  }

  /// Generate True or False questions
  Future<List<QuizQuestion>> generateTrueFalseQuiz({
    int? chapterNumber,
    int questionCount = 5,
  }) async {
    List<KuralModel> kurals;
    
    if (chapterNumber != null) {
      kurals = await isar.kuralModels
          .filter()
          .chapterNumberEqualTo(chapterNumber)
          .findAll();
    } else {
      final allKurals = await isar.kuralModels.where().findAll();
      kurals = (allKurals..shuffle()).take(questionCount * 2).toList();
    }

    if (kurals.isEmpty) return [];

    final questions = <QuizQuestion>[];
    
    for (int i = 0; i < min(questionCount, kurals.length); i++) {
      final kural = kurals[i];
      final isTrue = _random.nextBool();
      
      String statement;
      if (isTrue) {
        // Use the actual meaning
        statement = 'This Kural means: ${kural.meaningEnglish}';
      } else {
        // Use a wrong meaning from another kural
        final wrongKural = kurals[(i + 1) % kurals.length];
        statement = 'This Kural means: ${wrongKural.meaningEnglish}';
      }

      questions.add(QuizQuestion(
        id: i,
        type: QuizType.trueOrFalse,
        question: '${kural.line1Tamil}\n${kural.line2Tamil}\n\n$statement',
        options: const ['True', 'False'],
        correctAnswer: isTrue ? 'True' : 'False',
        hint: kural.meaningEnglish,
        kuralNumber: kural.number,
      ));
    }

    return questions;
  }
}
