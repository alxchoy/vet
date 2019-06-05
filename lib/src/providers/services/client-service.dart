import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/client-model.dart';
import '../../shared/constants.dart';
import './shared-preferences.dart';

class ClientService {
  static Future<dynamic> login(String userName, String password) async {
    Map<String, String> bodyRequest = {
      'userName': userName,
      'password': password,
      'grant_type': 'password',
      'rolId': '2'
    };

    return http.post(
    "${constants['urlBase']}/token",
      body: bodyRequest,
      headers: {
        "accept": "application/x-www-form-urlencoded",
        "content-type": "application/x-www-form-urlencoded"
      }
    );
  }

  static Future<dynamic> getClientId(String token) async {
    final response = await http.get("${constants['urlApi']}/token/claims",
      headers: {
        'Authorization': 'Bearer $token'
      }
    );

    if(response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falló el servicio getClientId');
    }
  }

  static Future<Client> getClientData(String token, String clientId) async {
    final response = await http.get("${constants['urlApi']}/client/$clientId",
      headers: {
        'Authorization': 'Bearer $token'
      }
    );

    if(response.statusCode == 200) {
      final responseDecode = json.decode(response.body);
      return Client.fromJson(responseDecode);
    } else {
      throw Exception('Falló el servicio getClientData');
    }
  }

  static Future<dynamic> createClient({form}) async {
    final token = await SharedPreferencesVet.getToken();
    final response = await http.post(
      "${constants['urlApi']}/client/createUser",
      body: json.encode(form),
      headers: {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json'
      }
    );

    if (response.statusCode == 200) {
      final responseDecode = json.decode(response.body);

      return responseDecode;
    } else {
      throw Exception('Falló el servicio createClient');
    }
  }

  static Future<dynamic> updateClient({form}) async {
    final token = await SharedPreferencesVet.getToken();
    final response = await http.post(
      "${constants['urlApi']}/client/updateDataClient",
      body: json.encode(form),
      headers: {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json'
      }
    );

    if (response.statusCode == 200) {
      final responseDecode = json.decode(response.body);

      return responseDecode;
    } else {
      throw Exception('Falló el servicio createClient');
    }
  }
}