import 'package:bloc/bloc.dart';
import 'package:coronavirus/repository/covid_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
      debugPrint('Loading region: ${event.region}');
      var info = await _repository.getStateInfo(event.region);
      var data = await _repository.getStateCurrent(event.region);

      emit(state.copyWith(
        status: RegionStatus.success,
        name: info.name,
        totalCases: data.total != null ? data.total.toString() : 'Sin datos',
        negativeTests:
            data.negative != null ? data.negative.toString() : 'Sin datos',
        deceased: data.death != null ? data.death.toString() : 'Sin datos',
        pendingTests:
            data.pending != null ? data.pending.toString() : 'Sin datos',
        confirmedCases: data.hospitalized != null
            ? data.hospitalized.toString()
            : 'Sin datos',
        positiveTests:
            data.positive != null ? data.positive.toString() : 'Sin datos',
        recovered:
            data.recovered != null ? data.recovered.toString() : 'Sin datos',
        notes: info.notes != null ? info.notes : 'Sin notas',
      ));
    } catch (error, stacktrace) {
      debugPrint(error.toString());
      debugPrint(stacktrace.toString());
      emit(
        state.copyWith(status: RegionStatus.failure, message: error.toString()),
      );
    }
  }
}
