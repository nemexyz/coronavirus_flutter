import 'package:bloc/bloc.dart';
import 'package:coronavirus/login/repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late UserRepository _repository;

  LoginBloc({required UserRepository repository}) : super(const LoginState()) {
    _repository = repository;
    on<LoginSubmit>(_onSubmit);
    on<RegisterSubmit>(_onRegister);
  }

  Future<void> _onSubmit(LoginSubmit event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      var user = await _repository.authenticate(
        type: event.type,
        identification: event.id,
        password: event.pass,
      );
      if (user == null) {
        emit(
          state.copyWith(
            status: LoginStatus.notFound,
            message: 'Usuario no encontrado',
          ),
        );
        return;
      }

      emit(state.copyWith(status: LoginStatus.success));
    } catch (error) {
      emit(
        state.copyWith(status: LoginStatus.failure, message: error.toString()),
      );
    }
  }

  Future<void> _onRegister(
    RegisterSubmit event,
    Emitter<LoginState> emit,
  ) async {
    try {
      await _repository.register(
        type: event.type,
        identification: event.id,
        password: event.pass,
      );

      emit(
        state.copyWith(
          status: LoginStatus.registered,
          message: 'Usuario registrado',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(status: LoginStatus.failure, message: error.toString()),
      );
    }
  }
}
