import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../shared/constants.dart';

class LookupsService {
  static loadLookups() async {
    Dio dio = new Dio();

    var response = await Future.wait([
      dio.get("${constants['urlApi']}/maintenance/species/search?filter"),
      dio.get("${constants['urlApi']}/maintenance/alimentation"),
      dio.get("${constants['urlApi']}/maintenance/vaccine"),
      dio.get("${constants['urlApi']}/maintenance/symptom"),
      dio.get("${constants['urlApi']}/lookup/pet/sex"),
      dio.get("${constants['urlApi']}/lookup/pet/enviroment"),
      dio.get("${constants['urlApi']}/lookup/pet/sizes"),
      dio.get("${constants['urlApi']}/lookup/client/documentType")
    ]);

    // final species = await dio.get("${constants['urlApi']}/maintenance/species/search?filter");
    // final aliments = await dio.get("${constants['urlApi']}/maintenance/alimentation");
    // final vaccines = await dio.get("${constants['urlApi']}/maintenance/vaccine");
    // final symptoms = await dio.get("${constants['urlApi']}/maintenance/symptom");
    // final sex = await dio.get("${constants['urlApi']}/lookup/pet/sex");
    // final habitat = await dio.get("${constants['urlApi']}/lookup/pet/enviroment");
    // final size = await dio.get("${constants['urlApi']}/lookup/pet/sizes");
    // final documents = await dio.get("${constants['urlApi']}/lookup/client/documentType");

    // final _validateResponse = (http.Response response) {
    //   if (response.statusCode == 200) {
    //     return jsonDecode(response.body);
    //   } else {
    //     throw Exception('Falló el servicio lookup');
    //   }
    // };

    // final response = {
    //   'aliments': _validateResponse(aliments),
    //   'documents': _validateResponse(documents),
    //   'habitat': _validateResponse(habitat),
    //   'sex': _validateResponse(sex),
    //   'size': _validateResponse(size),
    //   'species': _validateResponse(species),
    //   'symptoms': _validateResponse(symptoms),
    //   'vaccines': _validateResponse(vaccines)
    // };

    print('LOOKUPS SERVICE:: $response');

    return response;
  }
}