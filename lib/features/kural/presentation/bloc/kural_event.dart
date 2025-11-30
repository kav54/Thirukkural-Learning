part of 'kural_bloc.dart';

abstract class KuralEvent extends Equatable {
  const KuralEvent();

  @override
  List<Object> get props => [];
}

class GetDailyKuralEvent extends KuralEvent {}

class GetKuralByNumberEvent extends KuralEvent {
  final int number;

  const GetKuralByNumberEvent(this.number);

  @override
  List<Object> get props => [number];
}
