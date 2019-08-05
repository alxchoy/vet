import './base_service.dart';

class PetService extends BaseService{
  Future getPetsList({String clientId}) async {
    final response = await this.getBase(urlApi: "api/pet/ByClient/$clientId");

    return response.data;
  }
}