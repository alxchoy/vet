import 'dart:async';

import 'package:flutter/widgets.dart';

import '../resources/repository.dart';
import '../shared/shared_preferences_vet.dart';

import '../utils/helpers.dart';

class LoginBloc {
  final _repository = Repository();
  // final _loading = StreamController<bool>();

  // Stream<bool> get loadingStatus => _loading.stream;

  void fetchUserToken({String userName, String password, BuildContext context}) async {
    // _loading.sink.add(true);
    Helpers.showLoader(context: context);
    final data = await _repository.loginClient(userName: userName, password: password);
    await SharedPreferencesVet().setToken(data['access_token']);

    await this._fetchAllLookups(ctx: context);
  }

  void _fetchAllLookups({BuildContext ctx}) async {
    final lookups = await _repository.fetchLookups();
    await SharedPreferencesVet().setLookups(lookups);
    Helpers.dismissLoader(context: ctx);
    // _loading.sink.add(false);
  }
}