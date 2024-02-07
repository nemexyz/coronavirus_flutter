part of 'region_bloc.dart';

enum RegionStatus { initial, loading, success, failure }

final class RegionState extends Equatable {
  final RegionStatus status;
  final String message;

  const RegionState({
    this.status = RegionStatus.initial,
    this.message = '',
  });

  RegionState copyWith({
    RegionStatus? status,
    String? message,
  }) {
    return RegionState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, message];
}
