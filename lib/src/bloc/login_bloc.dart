import 'dart:async';

import 'package:flutter/widgets.dart';

import '../resources/repository.dart';
import '../shared/shared_preferences_vet.dart';

import '../utils/helpers.dart';

import './bloc_provider.dart';

class LoginBloc extends BlocBase {
  final _repository = Repository();

  void fetchToken({String userName, String password, BuildContext context}) async {
    Helpers.showLoader(context: context);
    final data = await _repository.loginClient(userName: userName, password: password);
    print(data);
    await SharedPreferencesVet().setToken(data['access_token']);

    await this._fetchAllLookups(ctx: context);
  }

  void _fetchAllLookups({BuildContext ctx}) async {
    final lookups = await _repository.fetchLookups();
    await SharedPreferencesVet().setLookups(lookups);
    Helpers.dismissLoader(context: ctx);
  }

  @override
  void dispose() {
    // implements dispose stream
  }
}