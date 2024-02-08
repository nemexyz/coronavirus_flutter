import 'dart:io' show Platform;

import 'package:bloc/bloc.dart';
import 'package:coronavirus/repository/covid_repository.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late CovidRepository _repository;

  HomeBloc({required CovidRepository repository}) : super(const HomeState()) {
    _repository = repository;
    on<LoadHome>(_onLoad);
  }

  Future<void> _onLoad(LoadHome event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      var data = await _repository.getCurrent();

      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final info = deviceInfo.data;

      DateTime date = data.dateChecked != null
          ? DateFormat("yyyy-MM-ddTHH:mm:ss").parse(data.dateChecked!)
          : DateTime.now();

      emit(state.copyWith(
        status: HomeStatus.success,
        time: DateFormat("HH:mm a").format(DateTime.now()).toLowerCase(),
        date: DateFormat("dd MM yyyy").format(date),
        deviceName: Platform.isIOS ? info['name'] : info['device'],
        deviceBrand: Platform.isIOS ? info['localizedModel'] : info['brand'],
        deviceType: info['isPhysicalDevice'] == 'true' ? 'Físico' : 'Emulador',
        deviceModel: info['model'],
        osVersion: Platform.isIOS
            ? info['systemName'] + ' ' + info['systemVersion']
            : info['version']['sdkInt'].toString(),
        totalCases: data.total.toString(),
        negativeTests: data.negative.toString(),
        deceased: data.death.toString(),
        pendingTests: data.pending.toString(),
        confirmedCases: data.hospitalized.toString(),
        positiveTests: data.positive.toString(),
        recovered:
            data.recovered != null ? data.recovered.toString() : 'Sin datos',
      ));
    } catch (error, stacktrace) {
      debugPrint(error.toString());
      debugPrint(stacktrace.toString());
      emit(
        state.copyWith(status: HomeStatus.failure, message: error.toString()),
      );
    }
  }
}
