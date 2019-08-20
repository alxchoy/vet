import './base_service.dart';

class ClientService extends BaseService {
  Future getClientId() async {
    final response = await this.getBase(urlApi: 'api/token/claims');

    return response.data;
  }

  Future createClient({Map form}) async {
    final response = await this.postBase(urlApi: 'api/client/createUser', bodyRequest: form);

    return response.data;
  }
}