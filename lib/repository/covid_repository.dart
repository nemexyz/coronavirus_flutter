import 'dart:io';

import 'package:coronavirus/home/model/current_model.dart';
import 'package:http/http.dart' show Client;

class CovidRepository {
  static const url = 'https://api.covidtracking.com';
  static const current = '/v1/us/current.json';

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
}
