import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../shared/constants.dart';
import './shared-preferences-service.dart';

class ProviderService {
  static Future<dynamic> getProviderDetails({int providerId}) async {
    final token = await SharedPreferencesVet.getToken();
    final response = await http.get("${constants['urlApi']}/provider/$providerId",
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
}