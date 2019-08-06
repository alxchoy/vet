import 'dart:async';

import './bloc_provider.dart';
import '../resources/repository.dart';

class AuthBloc extends BlocBase {
  final _repository = Repository();
  final _authController = StreamController();

  Stream get authData => _authController.stream;

  fetchToken({String userName, String password}) async {
    final response = await _repository.loginClient(userName: userName, password: password);
    print(response);
    _authController.sink.add(response);
  }

  @override
  void dispose() {
    _authController.close();
  }
}