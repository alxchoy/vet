class FoodPetClient {
  final int alimentationId;
  final String alimentationName;
  final int petAlimentationId;
  final int petId;
  final String petName;
  final String raceName;

  FoodPetClient({
    this.alimentationId,
    this.alimentationName,
    this.petAlimentationId,
    this.petId,
    this.petName,
    this.raceName
  });

  factory FoodPetClient.fromJson(Map<String, dynamic> json) => FoodPetClient(
    alimentationId: json['alimentationId'],
    alimentationName: json['alimentationName'],
    petAlimentationId: json['petAlimentationId'],
    petId: json['petId'],
    petName: json['petName'],
    raceName: json['raceName']
  );
}