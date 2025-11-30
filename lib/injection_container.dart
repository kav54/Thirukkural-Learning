import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'core/network/network_info.dart';
import 'features/kural/data/datasources/kural_local_data_source.dart';
import 'features/kural/data/models/kural_model.dart';
import 'features/kural/data/repositories/kural_repository_impl.dart';
import 'features/kural/domain/repositories/kural_repository.dart';
import 'features/kural/domain/usecases/get_daily_kural.dart';
import 'features/kural/presentation/bloc/kural_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Kural
  // Bloc
  sl.registerFactory(
    () => KuralBloc(
      getDailyKural: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetDailyKural(sl()));

  // Repository
  sl.registerLazySingleton<KuralRepository>(
    () => KuralRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<KuralLocalDataSource>(
    () => KuralLocalDataSourceImpl(isar: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [KuralModelSchema],
    directory: dir.path,
  );
  sl.registerLazySingleton(() => isar);
  sl.registerLazySingleton(() => Connectivity());
}
