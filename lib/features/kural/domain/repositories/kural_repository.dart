import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/kural.dart';

abstract class KuralRepository {
  Future<Either<Failure, Kural>> getDailyKural();
  Future<Either<Failure, List<Kural>>> getAllKurals();
  Future<Either<Failure, Kural>> getKuralByNumber(int number);
  Future<Either<Failure, List<Kural>>> getKuralsByChapter(int chapterNumber);
}
