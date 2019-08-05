import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesVet {
  void setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('vet_token', token);
  }

  void setClientId(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('vet_clientId', data);
  }

  void setLookups(String lookups) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('vet_lookups', lookups);
  }

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString('vet_token');
  }

  Future<String> getClientId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString('vet_clientId');
  }

  Future<String> getLookups() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString('vet_lookups');
  }
}