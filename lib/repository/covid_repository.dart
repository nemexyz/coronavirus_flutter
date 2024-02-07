import 'dart:io';

import 'package:coronavirus/home/model/current_model.dart';
import 'package:coronavirus/states/model/states_current_model.dart';
import 'package:coronavirus/states/model/states_info_model.dart';
import 'package:http/http.dart' show Client;

class CovidRepository {
  static const url = 'https://api.covidtracking.com';
  static const current = '/v1/us/current.json';
  static const info = '/v1/states/info.json';
  static const states = '/v1/states/current.json';

  static const flag = 'https://flagcdn.com/w160/';

  final Client _client = Client();

  Future<CurrentModel> getCurrent() async {
    final response = await _client.get(
      Uri.parse('$url$current'),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    final object = currentModelFromJson(response.body);

    if (response.statusCode == 200) {
      return object[0];
    } else {
      throw 'Error al obtener datos de la API';
    }
  }

  Future<List<StateInfoModel>> getStatesInfo() async {
    final response = await _client.get(
      Uri.parse('$url$info'),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    final object = statesInfoModelFromJson(response.body);

    if (response.statusCode == 200) {
      return object;
    } else {
      throw 'Error al obtener datos de la API';
    }
  }

  Future<List<StateCurrentModel>> getStatesCurrent() async {
    final response = await _client.get(
      Uri.parse('$url$states'),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    final object = statesCurrentModelFromJson(response.body);

    if (response.statusCode == 200) {
      return object;
    } else {
      throw 'Error al obtener datos de la API';
    }
  }
}
