import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import '../../features/kural/data/models/kural_model.dart';

class DataSeedingService {
  final Isar isar;

  DataSeedingService(this.isar);

  Future<void> seedKuralsIfNeeded() async {
    // Check if data already exists
    final count = await isar.kuralModels.count();
    if (count > 0) {
      print('Kurals already seeded: $count kurals found');
      return;
    }

    print('Seeding kurals from JSON...');
    
    try {
      // Load JSON from assets
      final jsonString = await rootBundle.loadString('assets/data/kurals.json');
      final jsonData = json.decode(jsonString);
      
      final features = jsonData['features'] as List;
      final kurals = <KuralModel>[];

      for (var feature in features) {
        final props = feature['properties'];
        
        // Parse the kural_tamil1 to extract two lines
        final kuralText = props['kural_tamil1'] as String;
        final lines = kuralText.split('\\n');
        
        final kural = KuralModel()
          ..number = props['kural_no'] as int
          ..line1Tamil = lines.isNotEmpty ? lines[0].trim() : ''
          ..line2Tamil = lines.length > 1 ? lines[1].trim() : ''
          ..meaningTamil = props['kuralvilakam_tamil'] as String
          ..meaningEnglish = props['kuralvilakam_english'] as String
          ..chapterNumber = props['adhikarm_no'] as int
          ..chapterName = props['adhikarm_tamil'] as String;
        
        kurals.add(kural);
      }

      // Save to Isar in a transaction
      await isar.writeTxn(() async {
        await isar.kuralModels.putAll(kurals);
      });

      print('Successfully seeded ${kurals.length} kurals!');
    } catch (e) {
      print('Error seeding kurals: $e');
      rethrow;
    }
  }
}
