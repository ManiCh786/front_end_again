import 'dart:convert';

// UsersModel usersModelFromJson(String str) => UsersModel.fromJson(json.decode(str));
//
// String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {

    int? userId;
  int? regId;
  String? fName;
  String? lName;
  String? email;
  String? phone;
  int? roleId;
  String? addedBy;
  dynamic? emailVerifiedAt;
  DateTime? registeredAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? roleName;
  UsersModel({
    this.userId,
    this.regId,
    this.fName,
    this.lName,
    this.email,
    this.phone,
    this.roleId,
    this.addedBy,
    this.emailVerifiedAt,
    this.registeredAt,
    this.createdAt,
    this.updatedAt,
    this.roleName,
  });




  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      userId: json["userId"],
      regId: json["regId"],
      fName: json["fName"],
      lName: json["lName"],
      email: json["email"],
      phone: json["phone"],
      roleId: json["roleId"],
      addedBy: json["added_by"],
      emailVerifiedAt: json["email_verified_at"],
      registeredAt: DateTime.parse(json["registered_at"]),
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      roleName:json['roleName'],

  );}

    Map<String, dynamic> toJson() => {
      "userId": userId,
      "regId": regId,
      "fName": fName,
      "lName": lName,
      "email": email,
      "phone": phone,
      "roleId": roleId,
      "added_by": addedBy,
      "email_verified_at": emailVerifiedAt,
      "registered_at": registeredAt?.toIso8601String(),
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }

