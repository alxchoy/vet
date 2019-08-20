import 'package:dio/dio.dart';

import '../../shared/constants.dart';
import '../../shared/shared_preferences_vet.dart';

class BaseService {
  Dio _dio = new Dio();
  String token;

  Future getBase({String urlApi}) async {
    try {
      await _addTokenInterceptor();
      return await _dio.get("${constants['urlBase']}/$urlApi");
    } on DioError catch(e) {
      print('Error Service: $e');
      throw Exception('Falló el servicio');
    }
  }

  Future postBase({String urlApi, Map bodyRequest, Options options}) async {
    try {
      await _addTokenInterceptor();
      return await _dio.post("${constants['urlBase']}/$urlApi", data: bodyRequest, options: options);
    } on DioError catch(e) {
      print('Error Service: $e');
      throw Exception('Falló el servicio');
    }
  }

  _addTokenInterceptor() async {
    token = await SharedPreferencesVet().getToken();
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