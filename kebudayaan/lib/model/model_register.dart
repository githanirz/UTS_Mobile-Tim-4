// To parse this JSON data, do
//
//     final modelRegister = modelRegisterFromJson(jsonString);

import 'dart:convert';

ModelRegister modelRegisterFromJson(String str) => ModelRegister.fromJson(json.decode(str));

String modelRegisterToJson(ModelRegister data) => json.encode(data.toJson());

class ModelRegister {
    int value;
    String username;
    String nama;
    String nohp;
    String email;
    String password;
    String message;

    ModelRegister({
        required this.value,
        required this.username,
        required this.nama,
        required this.nohp,
        required this.email,
        required this.password,
        required this.message,
    });

    factory ModelRegister.fromJson(Map<String, dynamic> json) => ModelRegister(
        value: json["value"],
        username: json["username"],
        nama: json["nama"],
        nohp: json["nohp"],
        email: json["email"],
        password: json["password"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "username": username,
        "nama": nama,
        "nohp": nohp,
        "email": email,
        "password": password,
        "message": message,
    };
}
