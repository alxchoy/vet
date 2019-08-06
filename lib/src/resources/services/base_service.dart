import 'package:dio/dio.dart';

import '../../shared/constants.dart';
import '../../shared/shared_preferences_vet.dart';

class BaseService {
  Dio _dio = new Dio(BaseOptions(
    receiveTimeout: 3000
  ));

  Future getBase({String urlApi}) async {
    try {
      await _tokenInterceptor();

      return await _dio.get("${constants['urlBase']}/$urlApi");
    } on DioError catch(e) {
      print('Error Service: $e');
      throw Exception('Falló el servicio');
    }
  }

  Future postBase({String urlApi, Map bodyRequest, Options options}) async {
    try {
      await _tokenInterceptor();

      return await _dio.post("${constants['urlBase']}/$urlApi", data: bodyRequest, options: options);
    } on DioError catch(e) {
      print('Error Service: $e');
      throw Exception('Falló el servicio');
    }
  }

  _tokenInterceptor() async {
    String token = await SharedPreferencesVet().getToken();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return options;
      }
    ));
  }

  // _handleErrorIntecerptor() {
  //   int retryCount = 0;

  //   _dio.interceptors.add(InterceptorsWrapper(
  //     onError: (DioError e) {
  //       retryCount += 1;
  //       if (retryCount <= 3) {
  //         e.response.request.receiveTimeout = 3000;

  //         RequestOptions options = e.response.request;

  //         return _dio.request(options.path, options: options);
  //       }

  //       return e;
  //     }
  //   ));
  // }
}