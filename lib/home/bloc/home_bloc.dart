import 'package:bloc/bloc.dart';
import 'package:coronavirus/repository/covid_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late CovidRepository _repository;

  HomeBloc({required CovidRepository repository}) : super(const HomeState()) {
    _repository = repository;
    on<LoadHome>(_onLoad);
  }

  void _onLoad(LoadHome event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
  }
}
