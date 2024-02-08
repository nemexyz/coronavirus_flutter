import 'dart:convert';

import 'package:coronavirus/login/model/user_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<UserModel?> getUser(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('user_$id');
    if (user == null) return null;
    return UserModel.fromJson(jsonDecode(user));
  }

  Future<UserModel> getDummy() async {
    var json = await rootBundle.loadString('assets/json/dummy.json');
    var object = await jsonDecode(json);
    var user = UserModel.fromJson(object);
    return user;
  }

  Future<UserModel?> authenticate({
    required String type,
    required String identification,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    UserModel? user = await getUser(identification);
    user ??= await getDummy();

    if (user.identification != identification) {
      return null;
    }

    if (user.type != type || user.password != password) {
      throw 'Usuario o contraseña incorrectos';
    }

    return user;
  }

  Future<void> register({
    required String type,
    required String identification,
    required String password,
  }) async {
    var user = UserModel(
      type: type,
      identification: identification,
      password: password,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_$identification', jsonEncode(user.toJson()));

    return;
  }
}
