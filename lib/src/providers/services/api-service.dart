import 'package:dio/dio.dart';

import '../../shared/constants.dart';

class ApiService {
  static getService({String apiUrl}) async {
    try {
      final dio = await Dio().get("${constants['base']}/$apiUrl");
      return dio;
    } on DioError catch(e) {
      print(e);
      print(e.response);
      print(e.request);
      return e;
    }
  }

  static postService({String apiUrl, Map bodyRequest, Options opts}) async {
    return Dio().post("${constants['urlBase']}/$apiUrl", data: bodyRequest, options: opts);
    // try {
    //   await Dio().post("${constants['urlBase']}/$apiUrl", data: bodyRequest, options: opts);
    // } on DioError catch(e) {
    //   print(e);
    //   print(e.response);
    //   print(e.request);
    //   return 'Error Service';
    // }
  }
}