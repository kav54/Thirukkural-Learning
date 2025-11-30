import 'package:isar/isar.dart';
import '../../../../core/error/exceptions.dart';
import '../models/kural_model.dart';

abstract class KuralLocalDataSource {
  Future<KuralModel> getDailyKural();
  Future<List<KuralModel>> getAllKurals();
  Future<KuralModel> getKuralByNumber(int number);
  Future<List<KuralModel>> getKuralsByChapter(int chapterNumber);
  Future<void> cacheKurals(List<KuralModel> kurals);
}

class KuralLocalDataSourceImpl implements KuralLocalDataSource {
  final Isar isar;

  KuralLocalDataSourceImpl({required this.isar});

  @override
  Future<KuralModel> getDailyKural() async {
    try {
      // Get kural based on current day of year (1-365)
      final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays + 1;
      final kuralNumber = (dayOfYear % 1330) + 1;
      
      final kural = await isar.kuralModels
          .filter()
          .numberEqualTo(kuralNumber)
          .findFirst();
      
      if (kural == null) {
        throw CacheException();
      }
      
      return kural;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<KuralModel>> getAllKurals() async {
    try {
      final kurals = await isar.kuralModels.where().findAll();
      if (kurals.isEmpty) {
        throw CacheException();
      }
      return kurals;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<KuralModel> getKuralByNumber(int number) async {
    try {
      final kural = await isar.kuralModels
          .filter()
          .numberEqualTo(number)
          .findFirst();
      
      if (kural == null) {
        throw CacheException();
      }
      
      return kural;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<KuralModel>> getKuralsByChapter(int chapterNumber) async {
    try {
      final kurals = await isar.kuralModels
          .filter()
          .chapterNumberEqualTo(chapterNumber)
          .findAll();
      
      if (kurals.isEmpty) {
        throw CacheException();
      }
      
      return kurals;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheKurals(List<KuralModel> kurals) async {
    try {
      await isar.writeTxn(() async {
        await isar.kuralModels.putAll(kurals);
      });
    } catch (e) {
      throw CacheException();
    }
  }
}
