import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/kural.dart';
import '../../domain/usecases/get_daily_kural.dart';

part 'kural_event.dart';
part 'kural_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class KuralBloc extends Bloc<KuralEvent, KuralState> {
  final GetDailyKural getDailyKural;

  KuralBloc({
    required this.getDailyKural,
  }) : super(KuralInitial()) {
    on<GetDailyKuralEvent>(_onGetDailyKural);
  }

  Future<void> _onGetDailyKural(
    GetDailyKuralEvent event,
    Emitter<KuralState> emit,
  ) async {
    emit(KuralLoading());
    
    final failureOrKural = await getDailyKural(NoParams());
    
    emit(failureOrKural.fold(
      (failure) => const KuralError(CACHE_FAILURE_MESSAGE),
      (kural) => KuralLoaded(kural),
    ));
  }
}
