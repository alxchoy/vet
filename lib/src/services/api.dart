import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'package:veterinary/src/services/shared_preferences.dart';
import 'package:veterinary/src/utils/constants.dart';
import 'package:veterinary/src/utils/helpers.dart';

class ApiService {
  Dio _dio = new Dio();
  String token;

  Future getApi({String urlApi, BuildContext context}) async {
    Helpers.showLoader(context: context);

    try {
      await _addTokenInterceptor();
      final response = await _dio.get("${constants['urlBase']}/$urlApi");
      Helpers.dismissLoader(context: context);

      return response;
    } on DioError catch(e) {
      Helpers.dismissLoader(context: context);
      print('Error Service: $e');
      throw Exception('Falló el servicio');
    }
  }

  Future postApi({String urlApi, Map bodyRequest, Options options, BuildContext context}) async {
    Helpers.showLoader(context: context);

    try {
      await _addTokenInterceptor();
      final response = await _dio.post("${constants['urlBase']}/$urlApi", data: bodyRequest, options: options);
      Helpers.dismissLoader(context: context);

      return response;
    } on DioError catch(e) {
      Helpers.dismissLoader(context: context);
      print('Error Service: $e');
      throw Exception('Falló el servicio');
    }
  }

  _addTokenInterceptor() async {
    token = await SharedPreferencesVet.getToken();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return options;
      }
    ));
  }
}