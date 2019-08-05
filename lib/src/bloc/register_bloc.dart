import 'dart:async';

import '../resources/repository.dart';

class RegisterBloc {
  final _repository = Repository();
  final _register = StreamController();

  fetchCreateClient({Map registerForm}) async {
    final response = await _repository.createClient(form: registerForm);
  }
}