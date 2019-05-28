import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pet-model.dart';
import '../models/disease-model.dart';
import '../models/provider-model.dart';
import '../../shared/constants.dart';
import './shared-preferences.dart';

class PetService {
  static Future<List<Pet>> getPetsList(String clientId) async {
    final token = await SharedPreferencesVet.getToken();
    final response = await http.get("${constants['urlApi']}/pet/ByClient/$clientId",
      headers: {
        'Authorization': 'Bearer $token'
      }
    );

    if(response.statusCode == 200) {
      final responseDecode = json.decode(response.body);
      List<Pet> pets = new List<Pet>();

      for (var pet in responseDecode) {
        pets.add(Pet.fromJson(pet));
      }

      return pets;
    } else {
      throw Exception('Falló el servicio getPetsList');
    }
  }

  static Future<List<dynamic>> getAlimentationsByPet(int petId) async {
    final token = await SharedPreferencesVet.getToken();
    final response = await http.get("${constants['urlApi']}/pet/getAlimentationByPet?PetId=$petId&AlimentationName",
      headers: {
        'Authorization': 'Bearer $token'
      }
    );

    if (response.statusCode == 200) {
      final responseDecode = json.decode(response.body);

      return responseDecode;
    } else {
      throw Exception('Falló el servicio getAlimentationsByPet');
    }
  }

  static Future<dynamic> deleteAlimentation(int alimentationId) async {
    var wasRemoved = false;
    final token = await SharedPreferencesVet.getToken();
    final response = await http.get("${constants['urlApi']}/pet/deleteAlimentation/$alimentationId",
      headers: {
        'Authorization': 'Bearer $token'
      }
    );

    if (response.statusCode == 200) {
      wasRemoved = true;
      return wasRemoved;
    } else {
      throw Exception('Falló el servicio getAlimentationsByPet');
    }
  }

  static Future<dynamic> addAlimentation(petId, alimentationId) async {
    final bodyRequest = {
      'alimentationId': alimentationId,
      'petId': petId
    };
    final token = await SharedPreferencesVet.getToken();
    final response = await http.post("${constants['urlApi']}/pet/addAlimentation",
      body: json.encode(bodyRequest),
      headers: {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json'
      }
    );

    if (response.statusCode == 200) {
      final responseDecode = json.decode(response.body);

      return responseDecode;
    } else {
      throw Exception('Falló el servicio getAlimentationsByPet');
    }
  }

  static Future<List<dynamic>> getVaccinesByPet(int petId) async {
    final token = await SharedPreferencesVet.getToken();
    final response = await http.get("${constants['urlApi']}/pet/getVaccinesByPet?PetId=$petId&VaccinesName",
      headers: {
        'Authorization': 'Bearer $token'
      }
    );

    if (response.statusCode == 200) {
      final responseDecode = json.decode(response.body);

      return responseDecode;
    } else {
      throw Exception('Falló el servicio getAlimentationsByPet');
    }
  }

  static Future<dynamic> deleteVaccine(int vaccineId) async {
    var wasRemoved = false;
    final token = await SharedPreferencesVet.getToken();
    final response = await http.get("${constants['urlApi']}/pet/deleteVaccine/$vaccineId",
      headers: {
        'Authorization': 'Bearer $token'
      }
    );

    if (response.statusCode == 200) {
      wasRemoved = true;
      return wasRemoved;
    } else {
      throw Exception('Falló el servicio getAlimentationsByPet');
    }
  }

  static Future<dynamic> addVaccine(petId, vaccineId) async {
    final bodyRequest = {
      'vaccineId': vaccineId,
      'petId': petId
    };
    final token = await SharedPreferencesVet.getToken();
    final response = await http.post("${constants['urlApi']}/pet/addVaccine",
      body: json.encode(bodyRequest),
      headers: {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json'
      }
    );

    if (response.statusCode == 200) {
      final responseDecode = json.decode(response.body);

      return responseDecode;
    } else {
      throw Exception('Falló el servicio getAlimentationsByPet');
    }
  }

  static Future<dynamic> reportPet(int petId, List<dynamic> symptomsIds) async {
    final listIds = symptomsIds.join(',');
    final token = await SharedPreferencesVet.getToken();
    final response = await http.get("${constants['urlApi']}/pet/GetDiagnostic?PetId=$petId&symptomIds=$listIds",
      headers: {
        'Authorization': 'Bearer $token'
      }
    );

    if (response.statusCode == 200) {
      final responseDecode = json.decode(response.body);
      List<Disease> diseases = List<Disease>();
      List<Provider> providers = List<Provider>();

      for (var disease in responseDecode['diseases']) {
        diseases.add(Disease.fromJson(disease));
      }

      for (var provider in responseDecode['providers']) {
        providers.add(Provider.fromJson(provider));
      }

      final data = {
        'diseases': diseases,
        'providers': providers
      };

      return data;
    } else {
      throw Exception('Falló el servicio getAlimentationsByPet');
    }
  }
}