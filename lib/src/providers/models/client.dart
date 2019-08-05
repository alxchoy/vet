import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
  final String clientCellPhoneNumber;
  final String clientDocumentNumber;
  final String clientDocumentType;
  final int clientDocumentTypeId;
  final String clientEmail;
  final String clientFullName;
  final int clientId;
  final String clientPhoneNumber;
  final String clientSex;
  final int clientSexId;
  final bool userBlocked;
  final int userId;
  final String userName;
  final String userNewPassword;
  final String userNewPasswordConfirm;
  final String userPassword;

  Client({
    this.clientCellPhoneNumber,
    this.clientDocumentNumber,
    this.clientDocumentType,
    this.clientDocumentTypeId,
    this.clientEmail,
    this.clientFullName,
    this.clientId,
    this.clientPhoneNumber,
    this.clientSex,
    this.clientSexId,
    this.userBlocked,
    this.userId,
    this.userName,
    this.userNewPassword,
    this.userNewPasswordConfirm,
    this.userPassword
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}