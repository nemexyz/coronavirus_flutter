part of 'region_bloc.dart';

enum RegionStatus { initial, loading, success, failure }

final class RegionState extends Equatable {
  final RegionStatus status;
  final String message;

  final String name;
  final String totalCases;
  final String negativeTests;
  final String deceased;
  final String pendingTests;
  final String confirmedCases;
  final String positiveTests;
  final String recovered;
  final String notes;

  const RegionState({
    this.status = RegionStatus.initial,
    this.message = '',
    this.name = '',
    this.totalCases = '',
    this.negativeTests = '',
    this.deceased = '',
    this.pendingTests = '',
    this.confirmedCases = '',
    this.positiveTests = '',
    this.recovered = '',
    this.notes = '',
  });

  RegionState copyWith({
    RegionStatus? status,
    String? message,
    String? name,
    String? totalCases,
    String? negativeTests,
    String? deceased,
    String? pendingTests,
    String? confirmedCases,
    String? positiveTests,
    String? recovered,
    String? notes,
  }) {
    return RegionState(
      status: status ?? this.status,
      message: message ?? this.message,
      name: name ?? this.name,
      totalCases: totalCases ?? this.totalCases,
      negativeTests: negativeTests ?? this.negativeTests,
      deceased: deceased ?? this.deceased,
      pendingTests: pendingTests ?? this.pendingTests,
      confirmedCases: confirmedCases ?? this.confirmedCases,
      positiveTests: positiveTests ?? this.positiveTests,
      recovered: recovered ?? this.recovered,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        name,
        totalCases,
        negativeTests,
        deceased,
        pendingTests,
        confirmedCases,
        positiveTests,
        recovered,
        notes,
      ];
}
