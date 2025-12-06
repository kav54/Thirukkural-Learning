import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import '../../../../core/services/streak_service.dart';
import '../../../../injection_container.dart' as di;

class WordleGamePage extends StatefulWidget {
  final List<String> wordPool;
  
  const WordleGamePage({
    super.key,
    required this.wordPool,
  });

  @override
  State<WordleGamePage> createState() => _WordleGamePageState();
}

class _WordleGamePageState extends State<WordleGamePage> with SingleTickerProviderStateMixin {
  late String targetWord;
  List<List<String>> guesses = [];
  List<String> currentGuess = [];
  int currentRow = 0;
  bool gameWon = false;
  bool gameLost = false;
  
  // Tamil keyboard layout
  final List<List<String>> keyboardRows = [
    ['அ', 'ஆ', 'இ', 'ஈ', 'உ', 'ஊ', 'எ', 'ஏ', 'ஐ', 'ஒ'],
    ['ஓ', 'ஔ', 'க', 'ங', 'ச', 'ஞ', 'ட', 'ண', 'த', 'ந'],
    ['ப', 'ம', 'ய', 'ர', 'ல', 'வ', 'ழ', 'ள', 'ற', 'ன'],
    ['ா', 'ி', 'ீ', 'ு', 'ூ', 'ெ', 'ே', 'ை', 'ொ', 'ோ'],
    ['ௌ', '்', 'ஃ', '⌫'],
  ];
  
  Map<String, LetterStatus> letterStatus = {};
  late AnimationController _shakeController;
  
  @override
  void initState() {
    super.initState();
    _initializeGame();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }
  
  void _initializeGame() {
    // Select a random word from the pool
    final random = Random();
    targetWord = widget.wordPool[random.nextInt(widget.wordPool.length)];
    
    // Initialize guesses (6 attempts, word length)
    guesses = List.generate(6, (_) => List.filled(targetWord.length, ''));
    currentGuess = [];
    currentRow = 0;
    gameWon = false;
    gameLost = false;
    letterStatus.clear();
  }
  
  void _onKeyPressed(String key) {
    if (gameWon || gameLost) return;
    
    setState(() {
      if (key == '⌫') {
        if (currentGuess.isNotEmpty) {
          currentGuess.removeLast();
        }
      } else if (currentGuess.length < targetWord.length) {
        currentGuess.add(key);
      }
      
      // Update current row display
      for (int i = 0; i < targetWord.length; i++) {
        guesses[currentRow][i] = i < currentGuess.length ? currentGuess[i] : '';
      }
    });
  }
  
  void _submitGuess() {
    if (currentGuess.length != targetWord.length) {
      _shakeController.forward(from: 0);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('சொல் முழுமையாக இல்லை!'),
          duration: const Duration(seconds: 1),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }
    
    setState(() {
      // Check the guess
      final guessWord = currentGuess.join('');
      final targetChars = targetWord.split('');
      final guessChars = currentGuess.toList();
      
      // First pass: mark correct positions (green)
      for (int i = 0; i < targetWord.length; i++) {
        if (guessChars[i] == targetChars[i]) {
          letterStatus[guessChars[i]] = LetterStatus.correct;
        }
      }
      
      // Second pass: mark present but wrong position (yellow)
      for (int i = 0; i < targetWord.length; i++) {
        if (guessChars[i] != targetChars[i] && targetChars.contains(guessChars[i])) {
          if (letterStatus[guessChars[i]] != LetterStatus.correct) {
            letterStatus[guessChars[i]] = LetterStatus.present;
          }
        } else if (guessChars[i] != targetChars[i]) {
          if (!letterStatus.containsKey(guessChars[i])) {
            letterStatus[guessChars[i]] = LetterStatus.absent;
          }
        }
      }
      
      // Check if won
      if (guessWord == targetWord) {
        gameWon = true;
        _showResultDialog(true);
      } else {
        currentRow++;
        currentGuess.clear();
        
        // Check if lost
        if (currentRow >= 6) {
          gameLost = true;
          _showResultDialog(false);
        }
      }
    });
  }
  
  void _showResultDialog(bool won) async {
    // Update streak on game completion (win or loss)
    final streakService = di.sl<StreakService>();
    final result = await streakService.updateStreak();
    
    if (mounted && (result.isNewRecord || !result.streakBroken)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    if (!mounted) return;

    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            won ? '🎉 வெற்றி!' : '😔 தோல்வி',
            style: GoogleFonts.notoSansTamil(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                won 
                  ? 'நீங்கள் ${currentRow + 1} முயற்சியில் வெற்றி பெற்றீர்கள்!'
                  : 'சரியான சொல்: $targetWord',
                style: GoogleFonts.notoSansTamil(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'வெளியேறு',
                      style: GoogleFonts.notoSansTamil(
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _initializeGame();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF97316),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'மீண்டும் விளையாடு',
                      style: GoogleFonts.notoSansTamil(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
  
  LetterStatus _getLetterStatus(int row, int col) {
    if (row > currentRow) return LetterStatus.unknown;
    if (row == currentRow) return LetterStatus.unknown;
    
    final letter = guesses[row][col];
    if (letter.isEmpty) return LetterStatus.unknown;
    
    final targetChars = targetWord.split('');
    if (targetChars[col] == letter) {
      return LetterStatus.correct;
    } else if (targetChars.contains(letter)) {
      return LetterStatus.present;
    } else {
      return LetterStatus.absent;
    }
  }
  
  Color _getBoxColor(LetterStatus status) {
    switch (status) {
      case LetterStatus.correct:
        return const Color(0xFF10B981); // Green
      case LetterStatus.present:
        return const Color(0xFFF59E0B); // Yellow/Amber
      case LetterStatus.absent:
        return const Color(0xFF64748B); // Gray
      case LetterStatus.unknown:
        return Colors.white;
    }
  }
  
  Color _getBorderColor(LetterStatus status, bool hasLetter) {
    if (status != LetterStatus.unknown) {
      return _getBoxColor(status);
    }
    return hasLetter ? const Color(0xFF94A3B8) : const Color(0xFFE2E8F0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildGameBoard(),
                    const SizedBox(height: 30),
                    _buildKeyboard(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
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
            '🧩 சொல் புதிர்',
            style: GoogleFonts.notoSansTamil(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(),
          ),
        ],
      ),
    );
  }
  
  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'எப்படி விளையாடுவது?',
          style: GoogleFonts.notoSansTamil(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHelpItem(
              '6 முயற்சிகளில் சொல்லை கண்டுபிடிக்கவும்',
              const Color(0xFF64748B),
            ),
            const SizedBox(height: 12),
            _buildHelpItem(
              '🟩 பச்சை - சரியான இடம்',
              const Color(0xFF10B981),
            ),
            const SizedBox(height: 8),
            _buildHelpItem(
              '🟨 மஞ்சள் - தவறான இடம்',
              const Color(0xFFF59E0B),
            ),
            const SizedBox(height: 8),
            _buildHelpItem(
              '⬜ சாம்பல் - சொல்லில் இல்லை',
              const Color(0xFF64748B),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'புரிந்தது',
              style: GoogleFonts.notoSansTamil(
                color: const Color(0xFFF97316),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHelpItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.notoSansTamil(fontSize: 14),
          ),
        ),
      ],
    );
  }
  
  Widget _buildGameBoard() {
    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        final offset = sin(_shakeController.value * 2 * pi) * 5;
        return Transform.translate(
          offset: Offset(offset, 0),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: List.generate(6, (row) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(targetWord.length, (col) {
                  final status = _getLetterStatus(row, col);
                  final letter = guesses[row][col];
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: TweenAnimationBuilder<double>(
                      key: ValueKey('$row-$col-${guesses[row][col]}'),
                      duration: row < currentRow 
                        ? Duration(milliseconds: 200 + (col * 100))
                        : const Duration(milliseconds: 0),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        // Use scale animation instead of flip to avoid mirroring
                        final scale = row < currentRow 
                          ? (value < 0.5 ? 1.0 - (value * 0.4) : 0.6 + ((value - 0.5) * 0.8))
                          : 1.0;
                        
                        final opacity = row < currentRow
                          ? (value < 0.5 ? 1.0 : value)
                          : 1.0;
                        
                        return Transform.scale(
                          scale: scale,
                          child: Opacity(
                            opacity: opacity,
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: row < currentRow 
                                  ? _getBoxColor(status)
                                  : Colors.white,
                                border: Border.all(
                                  color: _getBorderColor(status, letter.isNotEmpty),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                letter,
                                style: GoogleFonts.notoSansTamil(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: row < currentRow 
                                    ? Colors.white
                                    : const Color(0xFF1E293B),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            );
          }),
        ),
      ),
    );
  }
  
  Widget _buildKeyboard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          ...keyboardRows.map((row) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: row.map((key) {
                final status = letterStatus[key] ?? LetterStatus.unknown;
                final isBackspace = key == '⌫';
                
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _onKeyPressed(key),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        width: isBackspace ? 50 : 32,
                        height: 42,
                        decoration: BoxDecoration(
                          color: status == LetterStatus.unknown
                            ? const Color(0xFFE2E8F0)
                            : _getBoxColor(status),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: isBackspace
                          ? const Icon(Icons.backspace_outlined, size: 20, color: Color(0xFF1E293B))
                          : Text(
                              key,
                              style: GoogleFonts.notoSansTamil(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: status == LetterStatus.unknown
                                  ? const Color(0xFF1E293B)
                                  : Colors.white,
                              ),
                            ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _submitGuess,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF97316),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'சரிபார்',
              style: GoogleFonts.notoSansTamil(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum LetterStatus {
  unknown,
  absent,
  present,
  correct,
}
