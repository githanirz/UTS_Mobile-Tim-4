// To parse this JSON data, do
//
//     final modelUpdateSejarahwan = modelUpdateSejarahwanFromJson(jsonString);

import 'dart:convert';

ModelUpdateSejarahwan modelUpdateSejarahwanFromJson(String str) =>
    ModelUpdateSejarahwan.fromJson(json.decode(str));

String modelUpdateSejarahwanToJson(ModelUpdateSejarahwan data) =>
    json.encode(data.toJson());

class ModelUpdateSejarahwan {
  bool isSuccess;
  int value;
  String message;
  Data data;

  ModelUpdateSejarahwan({
    required this.isSuccess,
    required this.value,
    required this.message,
    required this.data,
  });

  factory ModelUpdateSejarahwan.fromJson(Map<String, dynamic> json) =>
      ModelUpdateSejarahwan(
        isSuccess: json["is_success"],
        value: json["value"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "is_success": isSuccess,
        "value": value,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String the0;
  String the1;
  String the2;
  DateTime the3;
  String the4;
  String the5;
  String the6;
  String id;
  String namaSejarah;
  String fotoSejarah;
  DateTime tanggalLahir;
  String asal;
  String jenisKelamin;
  String deskripsi;

  Data({
    required this.the0,
    required this.the1,
    required this.the2,
    required this.the3,
    required this.the4,
    required this.the5,
    required this.the6,
    required this.id,
    required this.namaSejarah,
    required this.fotoSejarah,
    required this.tanggalLahir,
    required this.asal,
    required this.jenisKelamin,
    required this.deskripsi,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        the0: json["0"],
        the1: json["1"],
        the2: json["2"],
        the3: DateTime.parse(json["3"]),
        the4: json["4"],
        the5: json["5"],
        the6: json["6"],
        id: json["id"],
        namaSejarah: json["nama_sejarah"],
        fotoSejarah: json["foto_sejarah"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        asal: json["asal"],
        jenisKelamin: json["jenis_kelamin"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "2": the2,
        "3": the3.toIso8601String(),
        "4": the4,
        "5": the5,
        "6": the6,
        "id": id,
        "nama_sejarah": namaSejarah,
        "foto_sejarah": fotoSejarah,
        "tanggal_lahir": tanggalLahir.toIso8601String(),
        "asal": asal,
        "jenis_kelamin": jenisKelamin,
        "deskripsi": deskripsi,
      };
}
