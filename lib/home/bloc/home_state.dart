part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

final class HomeState extends Equatable {
  final HomeStatus status;
  final String message;

  final String time;
  final String date;
  final String deviceName;
  final String deviceBrand;
  final String deviceType;
  final String deviceModel;
  final String osVersion;

  final String totalCases;
  final String negativeTests;
  final String deceased;
  final String pendingTests;
  final String confirmedCases;
  final String positiveTests;
  final String recovered;

  const HomeState({
    this.status = HomeStatus.initial,
    this.message = '',
    this.time = '',
    this.date = '',
    this.deviceName = '',
    this.deviceBrand = '',
    this.deviceType = '',
    this.deviceModel = '',
    this.osVersion = '',
    this.totalCases = '',
    this.negativeTests = '',
    this.deceased = '',
    this.pendingTests = '',
    this.confirmedCases = '',
    this.positiveTests = '',
    this.recovered = '',
  });

  HomeState copyWith({
    HomeStatus? status,
    String? message,
    String? time,
    String? date,
    String? deviceName,
    String? deviceBrand,
    String? deviceType,
    String? deviceModel,
    String? osVersion,
    String? totalCases,
    String? negativeTests,
    String? deceased,
    String? pendingTests,
    String? confirmedCases,
    String? positiveTests,
    String? recovered,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      time: time ?? this.time,
      date: date ?? this.date,
      deviceName: deviceName ?? this.deviceName,
      deviceBrand: deviceBrand ?? this.deviceBrand,
      deviceType: deviceType ?? this.deviceType,
      deviceModel: deviceModel ?? this.deviceModel,
      osVersion: osVersion ?? this.osVersion,
      totalCases: totalCases ?? this.totalCases,
      negativeTests: negativeTests ?? this.negativeTests,
      deceased: deceased ?? this.deceased,
      pendingTests: pendingTests ?? this.pendingTests,
      confirmedCases: confirmedCases ?? this.confirmedCases,
      positiveTests: positiveTests ?? this.positiveTests,
      recovered: recovered ?? this.recovered,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        time,
        date,
        deviceName,
        deviceBrand,
        deviceType,
        deviceModel,
        osVersion,
        totalCases,
        negativeTests,
        deceased,
        pendingTests,
        confirmedCases,
        positiveTests,
        recovered,
      ];
}
