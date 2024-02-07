part of 'states_bloc.dart';

enum StatesStatus { initial, loading, success, failure }

final class StateViewModel {
  final String state;
  final String url;
  final String name;
  final String total;
  final String modified;

  const StateViewModel({
    required this.state,
    required this.url,
    required this.name,
    required this.total,
    required this.modified,
  });
}

final class StatesState extends Equatable {
  final StatesStatus status;
  final String message;

  final List<StateViewModel> states;

  const StatesState({
    this.status = StatesStatus.initial,
    this.message = '',
    this.states = const [],
  });

  StatesState copyWith({
    StatesStatus? status,
    String? message,
    List<StateViewModel>? states,
  }) {
    return StatesState(
      status: status ?? this.status,
      message: message ?? this.message,
      states: states ?? this.states,
    );
  }

  @override
  List<Object> get props => [status, message, states];
}
