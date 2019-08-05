import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import './shared-preferences-service.dart';
import '../models/client-model.dart';
import '../../shared/constants.dart';

import './base-service.dart';
import './api-service.dart';

class ClientService extends BaseService {
  login({String userName, String password, context}) async {
    final response = await this.callService(context: context, service: () => (
      ApiService.postService(
        apiUrl: '/token',
        bodyRequest: {
          'userName': userName,
          'password': password,
          'grant_type': 'password',
          'rolId': '2'
        },
        opts: Options(contentType: ContentType.parse('application/x-www-form-urlencoded'))
      )
    ));

    print('prueba $response');

    return jsonDecode(response.toString());
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