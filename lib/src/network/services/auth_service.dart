import 'dart:io';

import 'package:dio/dio.dart';

import './base_service.dart';
import '../../shared/constants.dart';

class ClientService extends BaseService {
  Future login({String userName, String password}) async {
    var bodyReq = {
      'userName': userName,
      'password': password,
      'grant_type': 'password',
      'rolId': constants['rolId']
    };

    final response = await this.postBase(
      urlApi: 'token',
      bodyRequest: bodyReq,
      options: Options(contentType: ContentType.parse('application/x-www-form-urlencoded'))
    );

    return response.data;
  }
}