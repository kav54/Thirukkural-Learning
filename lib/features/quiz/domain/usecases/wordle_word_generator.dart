import 'dart:math';
import '../../../kural/domain/repositories/kural_repository.dart';
import '../../../kural/domain/entities/kural.dart';

class WordleWordGenerator {
  final KuralRepository repository;
  
  WordleWordGenerator(this.repository);
  
  /// Generate a pool of Tamil words from Kurals and Athikarams
  /// Words are 5 characters long for the Wordle game
  Future<List<String>> generateWordPool() async {
    final allKuralsResult = await repository.getAllKurals();
    final Set<String> wordPool = {};
    
    // Handle Either type - extract the list or return empty on failure
    final allKurals = allKuralsResult.fold(
      (failure) => <Kural>[], // Return empty list on failure
      (kurals) => kurals,     // Return the list on success
    );
    
    // Extract words from Kural lines
    for (final kural in allKurals) {
      // Get words from Tamil lines
      final line1Words = _extractWords(kural.line1Tamil);
      final line2Words = _extractWords(kural.line2Tamil);
      
      wordPool.addAll(line1Words);
      wordPool.addAll(line2Words);
    }
    
    // Also add chapter names (athikaram names)
    for (final kural in allKurals) {
      final chapterWords = _extractWords(kural.chapterName);
      wordPool.addAll(chapterWords);
    }
    
    // Filter to get 5-character words only
    final fiveLetterWords = wordPool
        .where((word) => word.length == 5)
        .toList();
    
    // If we don't have enough 5-letter words, create some from longer words
    if (fiveLetterWords.length < 50) {
      final additionalWords = _generateFromLongerWords(wordPool.toList());
      fiveLetterWords.addAll(additionalWords);
    }
    
    return fiveLetterWords;
  }
  
  /// Extract individual words from a Tamil sentence
  List<String> _extractWords(String text) {
    // Remove common punctuation and split by spaces
    final cleaned = text
        .replaceAll('!', '')
        .replaceAll('?', '')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll(';', '')
        .replaceAll(':', '')
        .replaceAll('"', '')
        .replaceAll("'", '')
        .trim();
    
    return cleaned
        .split(' ')
        .where((word) => word.isNotEmpty && _isValidTamilWord(word))
        .map((word) => word.trim())
        .toList();
  }
  
  /// Check if a word contains valid Tamil characters
  bool _isValidTamilWord(String word) {
    if (word.isEmpty) return false;
    
    // Tamil Unicode range: 0x0B80 to 0x0BFF
    for (int i = 0; i < word.length; i++) {
      final code = word.codeUnitAt(i);
      if (code < 0x0B80 || code > 0x0BFF) {
        return false;
      }
    }
    return true;
  }
  
  /// Generate 5-letter words from longer words by taking substrings
  List<String> _generateFromLongerWords(List<String> words) {
    final Set<String> generated = {};
    final random = Random();
    
    for (final word in words) {
      if (word.length > 5) {
        // Take first 5 characters
        generated.add(word.substring(0, 5));
        
        // Take last 5 characters
        if (word.length >= 5) {
          generated.add(word.substring(word.length - 5));
        }
        
        // Take random 5 characters from middle
        if (word.length > 6) {
          final start = random.nextInt(word.length - 5);
          generated.add(word.substring(start, start + 5));
        }
      }
    }
    
    return generated.where((w) => _isValidTamilWord(w)).toList();
  }
  
  /// Get a curated list of common Tamil words from Thirukkural context
  /// This is a fallback if we can't generate enough words from Kurals
  List<String> getCuratedWordList() {
    return [
      'அறிவு', // Knowledge
      'அன்பு', // Love
      'நன்மை', // Goodness
      'தருமம்', // Dharma
      'வாழ்வு', // Life
      'உலகம்', // World
      'மக்கள்', // People
      'நாடு', // Country (4 letters, but keeping for context)
      'கல்வி', // Education
      'பண்பு', // Culture
      'மனம்', // Mind (4 letters)
      'செயல்', // Action
      'உண்மை', // Truth
      'நீதி', // Justice (4 letters)
      'அறம்', // Virtue (4 letters)
      'பொருள்', // Wealth
      'இன்பம்', // Pleasure
      'வீடு', // Liberation (4 letters)
      'கடவுள்', // God
      'மனிதன்', // Human
      'சமயம்', // Religion
      'தொழில்', // Profession
      'குடும்பம்', // Family (7 letters)
      'நட்பு', // Friendship (4 letters)
      'காதல்', // Love
      'மரியாதை', // Respect (8 letters)
      'பணிவு', // Humility
      'கொடை', // Charity (4 letters)
      'நன்றி', // Gratitude (4 letters)
      'மகிழ்ச்சி', // Happiness (8 letters)
    ].where((word) => word.length == 5).toList();
  }
  
  /// Get daily word - same word for the same day
  Future<String> getDailyWord() async {
    final wordPool = await generateWordPool();
    
    if (wordPool.isEmpty) {
      // Fallback to curated list
      final curated = getCuratedWordList();
      if (curated.isEmpty) {
        return 'அன்பு'; // Ultimate fallback
      }
      return _getDailyWordFromList(curated);
    }
    
    return _getDailyWordFromList(wordPool);
  }
  
  String _getDailyWordFromList(List<String> words) {
    // Use current date as seed for consistent daily word
    final now = DateTime.now();
    final daysSinceEpoch = now.difference(DateTime(2024, 1, 1)).inDays;
    final random = Random(daysSinceEpoch);
    
    return words[random.nextInt(words.length)];
  }
}
