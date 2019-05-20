import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/client-model.dart';

class ClientService {
  static Future<dynamic> login(String userName, String password) async {
    Map<String, String> bodyRequest = {
      'userName': userName,
      'password': password,
      'grant_type': 'password',
      'rolId': '2'
    };

    return http.post(
    'http://vetitapp-001-site1.itempurl.com/token',
      body: bodyRequest,
      headers: {
        "accept": "application/x-www-form-urlencoded",
        "content-type": "application/x-www-form-urlencoded"
      }
    );
  }

  static Future<dynamic> getClientId(String token) async {
    final response = await http.get('http://vetitapp-001-site1.itempurl.com/api/token/claims',
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
    final response = await http.get('http://vetitapp-001-site1.itempurl.com/api/client/$clientId',
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
}