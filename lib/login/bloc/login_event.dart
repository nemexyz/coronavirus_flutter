part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginSubmit extends LoginEvent {
  final String type;
  final String id;
  final String pass;

  LoginSubmit({
    required this.type,
    required this.id,
    required this.pass,
  });
}

class RegisterSubmit extends LoginSubmit {
  RegisterSubmit({
    required String type,
    required String id,
    required String pass,
  }) : super(type: type, id: id, pass: pass);
}
