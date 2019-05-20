class Pet {
  final String clientName;
  final String habitad;
  final String petBirthDay;
  final String petName;
  final String petPathImage;
  final String petSize;
  final String raceName;
  final String sex;
  final String specieName;
  final dynamic alimentations;
  final dynamic vaccines;
  final int clientId;
  final int habitadId;
  final int petAge;
  final int petId;
  final int petSizeId;
  final double petWeight;
  final int raceId;
  final int sexId;
  final int specieId;

  Pet({this.clientName, this.habitad, this.petBirthDay, this.petName, this.petPathImage, this.petSize, this.raceName, this.sex, this.specieName, this.alimentations, this.vaccines, this.clientId, this.habitadId, this.petAge, this.petId, this.petSizeId, this.petWeight, this.raceId, this.sexId, this.specieId});

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
    alimentations: json['alimentations'],
    clientId: json['clientId'],
    clientName: json['clientName'],
    habitad: json['habitad'],
    habitadId: json['habitadId'],
    petAge: json['petAge'],
    petBirthDay: json['petBirthDay'],
    petId: json['petId'],
    petName: json['petName'],
    petPathImage: json['petPathImage'],
    petSize: json['petSize'],
    petSizeId: json['petSizeId'],
    petWeight: json['petWeight'],
    raceId: json['raceId'],
    raceName: json['raceName'],
    sex: json['sex'],
    sexId: json['sexId'],
    specieId: json['specieId'],
    specieName: json['specieName'],
    vaccines: json['vaccines'],
  );
}