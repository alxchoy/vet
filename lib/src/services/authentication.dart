import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:veterinary/src/services/api.dart';

class AuthenticationService {
  logIn({String userName, String userPassword, BuildContext context}) async {
    final data = await ApiService().postApi(
      urlApi: '/token',
      bodyRequest: {
        'userName': userName,
        'password': userPassword,
        'grant_type': 'password',
        'rolId': '2'
      },
      options: Options(contentType: ContentType.parse('application/x-www-form-urlencoded')),
      context: context
    );

    print(data);

    return jsonDecode(data);
  }
}