part of 'kural_bloc.dart';

abstract class KuralState extends Equatable {
  const KuralState();

  @override
  List<Object> get props => [];
}

class KuralInitial extends KuralState {}

class KuralLoading extends KuralState {}

class KuralLoaded extends KuralState {
  final Kural kural;

  const KuralLoaded(this.kural);

  @override
  List<Object> get props => [kural];
}

class KuralError extends KuralState {
  final String message;

  const KuralError(this.message);

  @override
  List<Object> get props => [message];
}
