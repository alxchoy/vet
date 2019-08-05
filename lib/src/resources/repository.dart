import './services/client_service.dart';
import './services/lookups_service.dart';
import './services/pet_service.dart';

class Repository {
  final _clientService = ClientService();
  final _petService = PetService();

  Future fetchLookups() => LookupsService().loadLookups();

  // Client
  Future loginClient({String userName, String password}) => _clientService.login(userName: userName, password: password);
  Future getClientId() => _clientService.getClientId();
  Future createClient({Map form}) => _clientService.createClient(form: form);

  // Pets
  Future fetchPetsList({String clientId}) => _petService.getPetsList(clientId: clientId);

}