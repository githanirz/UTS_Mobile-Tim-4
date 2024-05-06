// To parse this JSON data, do
//
//     final modelEditUser = modelEditUserFromJson(jsonString);

import 'dart:convert';

ModelEditUser modelEditUserFromJson(String str) =>
    ModelEditUser.fromJson(json.decode(str));

String modelEditUserToJson(ModelEditUser data) => json.encode(data.toJson());

class ModelEditUser {
  bool isSuccess;
  int value;
  String message;
  String username;
  String nama;
  String nohp;
  String email;
  String idUser;

  ModelEditUser({
    required this.isSuccess,
    required this.value,
    required this.message,
    required this.username,
    required this.nama,
    required this.nohp,
    required this.email,
    required this.idUser,
  });

  factory ModelEditUser.fromJson(Map<String, dynamic> json) => ModelEditUser(
        isSuccess: json["is_success"],
        value: json["value"],
        message: json["message"],
        username: json["username"],
        nama: json["nama"],
        nohp: json["nohp"],
        email: json["email"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "is_success": isSuccess,
        "value": value,
        "message": message,
        "username": username,
        "nama": nama,
        "nohp": nohp,
        "email": email,
        "id_user": idUser,
      };
}
