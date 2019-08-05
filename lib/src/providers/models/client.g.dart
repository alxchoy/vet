// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) {
  return Client(
    clientCellPhoneNumber: json['clientCellPhoneNumber'] as String,
    clientDocumentNumber: json['clientDocumentNumber'] as String,
    clientDocumentType: json['clientDocumentType'] as String,
    clientDocumentTypeId: json['clientDocumentTypeId'] as int,
    clientEmail: json['clientEmail'] as String,
    clientFullName: json['clientFullName'] as String,
    clientId: json['clientId'] as int,
    clientPhoneNumber: json['clientPhoneNumber'] as String,
    clientSex: json['clientSex'] as String,
    clientSexId: json['clientSexId'] as int,
    userBlocked: json['userBlocked'] as bool,
    userId: json['userId'] as int,
    userName: json['userName'] as String,
    userNewPassword: json['userNewPassword'] as String,
    userNewPasswordConfirm: json['userNewPasswordConfirm'] as String,
    userPassword: json['userPassword'] as String,
  );
}

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'clientCellPhoneNumber': instance.clientCellPhoneNumber,
      'clientDocumentNumber': instance.clientDocumentNumber,
      'clientDocumentType': instance.clientDocumentType,
      'clientDocumentTypeId': instance.clientDocumentTypeId,
      'clientEmail': instance.clientEmail,
      'clientFullName': instance.clientFullName,
      'clientId': instance.clientId,
      'clientPhoneNumber': instance.clientPhoneNumber,
      'clientSex': instance.clientSex,
      'clientSexId': instance.clientSexId,
      'userBlocked': instance.userBlocked,
      'userId': instance.userId,
      'userName': instance.userName,
      'userNewPassword': instance.userNewPassword,
      'userNewPasswordConfirm': instance.userNewPasswordConfirm,
      'userPassword': instance.userPassword,
    };
