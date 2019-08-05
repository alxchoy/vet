import 'dart:async';

import '../resources/repository.dart';


class BandejaBloc {
  final _repository = Repository();
  final _pets = StreamController();

  Stream get allpets => _pets.stream;

  fetchAllPets() async {
    final clientId = await _repository.getClientId();
    final response = await _repository.fetchPetsList(clientId: clientId['idLogIn']);
    _pets.sink.add(response);
  }

  void dispose() {
    _pets.close();
  }
}