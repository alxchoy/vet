import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesVet {
  static setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('vet_token', token);
  }
}