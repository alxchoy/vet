import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesVet {
  static setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('vet_token', token);
  }

  static Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('vet_token');
  }

  static Future<void> setClientId(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('vet_clientId', data);
  }

  static Future<String> getClientId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('vet_clientId');
  }

  static Future<void> setLookups(String lookups) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('vet_lookups', lookups);
  }

  static Future<String> getLookups() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('vet_lookups');
  }
}