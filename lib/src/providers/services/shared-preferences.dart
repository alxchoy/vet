import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesVet {
  static setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('vet_token', token);
  }

  static Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('vet_token') ?? null;
  }

  static Future<void> setClientId(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('vet_clientId', data);
  }

  static Future<String> getClientId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('vet_clientId') ?? null;
  }
}