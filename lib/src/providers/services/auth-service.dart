import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import './shared-preferences.dart';

class AuthService {
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

    // final response = await
    //   http.post(
    //     'http://vetitapp-001-site1.itempurl.com/token',
    //     body: bodyRequest,
    //     headers: {
    //       "accept": "application/x-www-form-urlencoded",
    //       "content-type": "application/x-www-form-urlencoded"
    //     }
    //   );

    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);
    //   print(data['access_token']);
    //   SharedPreferencesVet.setToken(data['access_token']);
    // } else {
    //   print(response.statusCode);
    //   print(response.body);
    //   throw Exception('Failed to load post');
    // }
  }
}