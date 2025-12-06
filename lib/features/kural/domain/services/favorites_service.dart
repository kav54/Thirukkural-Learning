import 'package:isar/isar.dart';
import '../../data/models/kural_model.dart';

/// Service to manage favorite kurals
class FavoritesService {
  final Isar _isar;

  FavoritesService(this._isar);

  /// Toggle favorite status for a kural
  Future<bool> toggleFavorite(int kuralNumber) async {
    final kural = await _isar.kuralModels
        .filter()
        .numberEqualTo(kuralNumber)
        .findFirst();

    if (kural == null) return false;

    await _isar.writeTxn(() async {
      kural.isFavorite = !kural.isFavorite;
      await _isar.kuralModels.put(kural);
    });

    return kural.isFavorite;
  }

  /// Set favorite status for a kural
  Future<void> setFavorite(int kuralNumber, bool isFavorite) async {
    final kural = await _isar.kuralModels
        .filter()
        .numberEqualTo(kuralNumber)
        .findFirst();

    if (kural == null) return;

    await _isar.writeTxn(() async {
      kural.isFavorite = isFavorite;
      await _isar.kuralModels.put(kural);
    });
  }

  /// Check if a kural is favorited
  Future<bool> isFavorite(int kuralNumber) async {
    final kural = await _isar.kuralModels
        .filter()
        .numberEqualTo(kuralNumber)
        .findFirst();

    return kural?.isFavorite ?? false;
  }

  /// Get all favorite kurals
  Future<List<KuralModel>> getAllFavorites() async {
    return await _isar.kuralModels
        .filter()
        .isFavoriteEqualTo(true)
        .sortByNumber()
        .findAll();
  }

  /// Get favorite count
  Future<int> getFavoriteCount() async {
    return await _isar.kuralModels
        .filter()
        .isFavoriteEqualTo(true)
        .count();
  }

  /// Get favorites by chapter
  Future<List<KuralModel>> getFavoritesByChapter(int chapterNumber) async {
    return await _isar.kuralModels
        .filter()
        .isFavoriteEqualTo(true)
        .and()
        .chapterNumberEqualTo(chapterNumber)
        .sortByNumber()
        .findAll();
  }

  /// Clear all favorites
  Future<void> clearAllFavorites() async {
    final favorites = await getAllFavorites();
    
    await _isar.writeTxn(() async {
      for (var kural in favorites) {
        kural.isFavorite = false;
        await _isar.kuralModels.put(kural);
      }
    });
  }

  /// Stream of favorite count (for real-time updates)
  Stream<int> watchFavoriteCount() {
    return _isar.kuralModels
        .filter()
        .isFavoriteEqualTo(true)
        .watch(fireImmediately: true)
        .map((kurals) => kurals.length);
  }

  /// Stream of all favorites (for real-time updates)
  Stream<List<KuralModel>> watchFavorites() {
    return _isar.kuralModels
        .filter()
        .isFavoriteEqualTo(true)
        .sortByNumber()
        .watch(fireImmediately: true);
  }
}
