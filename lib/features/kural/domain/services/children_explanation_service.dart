import 'dart:convert';
import 'package:flutter/services.dart';

/// Service to load child-friendly explanations for Thirukkural verses
class ChildrenExplanationService {
  static final ChildrenExplanationService _instance = ChildrenExplanationService._internal();
  factory ChildrenExplanationService() => _instance;
  ChildrenExplanationService._internal();

  Map<int, String>? _explanations;
  bool _isLoaded = false;

  /// Load children explanations from JSON file
  Future<void> loadExplanations() async {
    if (_isLoaded) return;

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/children_explanations.json',
      );
      
      final Map<String, dynamic> data = json.decode(jsonString);
      final List<dynamic> explanationsList = data['explanations'];

      _explanations = {};
      for (var item in explanationsList) {
        final int kuralNo = item['kural_no'];
        final String explanation = item['child_explanation'];
        _explanations![kuralNo] = explanation;
      }

      _isLoaded = true;
      print('✅ Loaded ${_explanations!.length} children explanations');
    } catch (e) {
      print('❌ Error loading children explanations: $e');
      _explanations = {};
    }
  }

  /// Get child-friendly explanation for a specific kural number
  String? getExplanation(int kuralNumber) {
    if (!_isLoaded || _explanations == null) {
      return null;
    }
    return _explanations![kuralNumber];
  }

  /// Get explanation with fallback
  String getExplanationOrDefault(int kuralNumber, String defaultText) {
    return getExplanation(kuralNumber) ?? defaultText;
  }

  /// Check if explanations are loaded
  bool get isLoaded => _isLoaded;

  /// Get total count of loaded explanations
  int get count => _explanations?.length ?? 0;
}
