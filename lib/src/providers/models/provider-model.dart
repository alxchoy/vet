class Provider {
  final String headquaterDescription;
  final String headquaterEmail;
  final int headquaterId;
  final String headquaterPhone;
  final String headqueaterAddress;
  final String latitud;
  final String longitud;
  final String pathImage;
  final String providerDocumentNumber;
  final String providerDocumentType;
  final int providerId;
  final String providerName;

  Provider({
    this.headquaterDescription,
    this.headquaterEmail,
    this.headquaterId,
    this.headquaterPhone,
    this.headqueaterAddress,
    this.latitud,
    this.longitud,
    this.pathImage,
    this.providerDocumentNumber,
    this.providerDocumentType,
    this.providerId,
    this.providerName
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
    headquaterDescription: json['headquaterDescription'],
    headquaterEmail: json['headquaterEmail'],
    headquaterId: json['headquaterId'],
    headquaterPhone: json['headquaterPhone'],
    headqueaterAddress: json['headqueaterAddress'],
    latitud: json['latitud'],
    longitud: json['longitud'],
    pathImage: json['pathImage'],
    providerDocumentNumber: json['providerDocumentNumber'],
    providerDocumentType: json['providerDocumentType'],
    providerId: json['providerId'],
    providerName: json['providerName']
  );
}