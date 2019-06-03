import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../shared/constants.dart';

class LookupsService {
  static Future<Map<String, dynamic>> loadLookups() async {
    final species = await http.get("${constants['urlApi']}/maintenance/species/search?filter");
    final aliments = await http.get("${constants['urlApi']}/maintenance/alimentation");
    final vaccines = await http.get("${constants['urlApi']}/maintenance/vaccine");
    final symptoms = await http.get("${constants['urlApi']}/maintenance/symptom");
    final sex = await http.get("${constants['urlApi']}/lookup/pet/sex");
    final habitat = await http.get("${constants['urlApi']}/lookup/pet/enviroment");
    final size = await http.get("${constants['urlApi']}/lookup/pet/sizes");
    final documents = await http.get("${constants['urlApi']}/lookup/client/documentType");

    final _validateResponse = (http.Response response) {
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Falló el servicio lookup');
      }
    };

    final response = {
      'aliments': _validateResponse(aliments),
      'documents': _validateResponse(documents),
      'habitat': _validateResponse(habitat),
      'sex': _validateResponse(sex),
      'size': _validateResponse(size),
      'species': _validateResponse(species),
      'symptoms': _validateResponse(symptoms),
      'vaccines': _validateResponse(vaccines)
    };

    print(response['documents']);

    return response;
  }
}