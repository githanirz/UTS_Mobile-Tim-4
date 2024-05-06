// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelLogin modelLoginFromJson(String str) => ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
    int value;
    String message;
    String username;
    String nama;
    String nohp;
    String email;
    String id_user;

    ModelLogin({
        required this.value,
        required this.message,
        required this.username,
        required this.nama,
        required this.nohp,
        required this.email,
        required this.id_user,
    });

    factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
        value: json["value"],
        message: json["message"],
        username: json["username"],
        nama: json["nama"],
        nohp: json["nohp"],
        email: json["email"],
        id_user: json["id_user"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "username": username,
        "nama": nama,
        "nohp": nohp,
        "email": email,
        "id_user": id_user,
    };
}
