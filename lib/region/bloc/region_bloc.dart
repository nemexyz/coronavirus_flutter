import 'package:bloc/bloc.dart';
import 'package:coronavirus/repository/covid_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

part 'region_event.dart';
part 'region_state.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  late CovidRepository _repository;

  RegionBloc({required CovidRepository repository})
      : super(const RegionState()) {
    _repository = repository;
    on<LoadRegion>(_onLoad);
  }

  void _onLoad(LoadRegion event, Emitter<RegionState> emit) async {
    emit(state.copyWith(status: RegionStatus.loading));

    try {
      var info = await _repository.getStateInfo('');

      emit(state.copyWith(status: RegionStatus.success));
    } catch (error) {
      debugPrint(error.toString());
      emit(
        state.copyWith(status: RegionStatus.failure, message: error.toString()),
      );
    }
  }
}
