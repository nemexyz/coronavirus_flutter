import 'package:bloc/bloc.dart';
import 'package:coronavirus/repository/covid_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

part 'states_event.dart';
part 'states_state.dart';

class StatesBloc extends Bloc<StatesEvent, StatesState> {
  late CovidRepository _repository;

  StatesBloc({required CovidRepository repository})
      : super(const StatesState()) {
    _repository = repository;
    on<LoadStates>(_onLoad);
  }

  void _onLoad(LoadStates event, Emitter<StatesState> emit) async {
    emit(state.copyWith(status: StatesStatus.loading));

    try {
      var info = await _repository.getStatesInfo();
      var current = await _repository.getStatesCurrent();

      List<StateViewModel> states = [];

      for (var i = 0; i < info.length; i++) {
        var state = info[i];
        var currentInfo = current.firstWhere(
          (element) => element.state == state.state,
        );

        states.add(
          StateViewModel(
            state: state.state,
            url: '${CovidRepository.flag}us-${state.state.toLowerCase()}.png',
            name: state.name,
            total: currentInfo.total.toString(),
            modified: currentInfo.dateModified != null
                ? DateFormat("dd MMM yyyy", 'es_ES')
                    .format(currentInfo.dateModified!)
                : "Sin fecha",
          ),
        );
      }

      emit(state.copyWith(status: StatesStatus.success, states: states));
    } catch (error, stacktrace) {
      debugPrint(error.toString());
      emit(
        state.copyWith(status: StatesStatus.failure, message: error.toString()),
      );
    }
  }
}
