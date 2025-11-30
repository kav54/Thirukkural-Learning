import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/kural.dart';
import '../../domain/repositories/kural_repository.dart';
import '../datasources/kural_local_data_source.dart';

class KuralRepositoryImpl implements KuralRepository {
  final KuralLocalDataSource localDataSource;

  KuralRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Kural>> getDailyKural() async {
    try {
      final localKural = await localDataSource.getDailyKural();
      return Right(localKural.toEntity());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Kural>>> getAllKurals() async {
    try {
      final localKurals = await localDataSource.getAllKurals();
      return Right(localKurals.map((model) => model.toEntity()).toList());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Kural>> getKuralByNumber(int number) async {
    try {
      final localKural = await localDataSource.getKuralByNumber(number);
      return Right(localKural.toEntity());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Kural>>> getKuralsByChapter(
      int chapterNumber) async {
    try {
      final localKurals =
          await localDataSource.getKuralsByChapter(chapterNumber);
      return Right(localKurals.map((model) => model.toEntity()).toList());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
