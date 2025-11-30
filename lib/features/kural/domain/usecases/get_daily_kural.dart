import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/kural.dart';
import '../repositories/kural_repository.dart';

class GetDailyKural implements UseCase<Kural, NoParams> {
  final KuralRepository repository;

  GetDailyKural(this.repository);

  @override
  Future<Either<Failure, Kural>> call(NoParams params) async {
    return await repository.getDailyKural();
  }
}
