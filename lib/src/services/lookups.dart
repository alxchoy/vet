import 'dart:async';

import 'package:dio/dio.dart';

import 'package:veterinary/src/utils/constants.dart';

class LookupsService {
  loadLookups() async {
    Dio _dio = new Dio();

    final lookupsList = await Future.wait([
      _dio.get("${constants['urlApi']}/maintenance/species/search?filter"),
      _dio.get("${constants['urlApi']}/maintenance/alimentation"),
      _dio.get("${constants['urlApi']}/maintenance/vaccine"),
      _dio.get("${constants['urlApi']}/maintenance/symptom"),
      _dio.get("${constants['urlApi']}/lookup/pet/sex"),
      _dio.get("${constants['urlApi']}/lookup/pet/enviroment"),
      _dio.get("${constants['urlApi']}/lookup/pet/sizes"),
      _dio.get("${constants['urlApi']}/lookup/client/documentType")
    ]);

    final response = {
      'aliments': lookupsList[1].data,
      'documents': lookupsList[7].data,
      'habitat': lookupsList[5].data,
      'sex': lookupsList[4].data,
      'size': lookupsList[6].data,
      'species': lookupsList[0].data,
      'symptoms': lookupsList[3].data,
      'vaccines': lookupsList[2].data
    };

    return response;
  }
}