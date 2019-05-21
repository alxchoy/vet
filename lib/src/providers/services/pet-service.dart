import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pet-model.dart';
import '../../shared/constants.dart';

class PetService {
  static Future<List<Pet>> getPetsList(String token, String clientId) async {
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
}