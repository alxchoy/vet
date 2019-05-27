class Disease {
  final int countSymptom;
  final String diseaseDescription;
  final int diseaseId;
  final String diseaseName;

  Disease({this.countSymptom, this.diseaseDescription, this.diseaseId, this.diseaseName});

  factory Disease.fromJson(Map<String, dynamic> json) => Disease(
    countSymptom: json['countSymptom'],
    diseaseDescription: json['diseaseDescription'],
    diseaseId: json['diseaseId'],
    diseaseName: json['diseaseName']
  );
}