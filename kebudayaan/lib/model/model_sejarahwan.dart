// To parse this JSON data, do
//
//     final modelSejarahwan = modelSejarahwanFromJson(jsonString);

import 'dart:convert';

ModelSejarahwan modelSejarahwanFromJson(String str) => ModelSejarahwan.fromJson(json.decode(str));

String modelSejarahwanToJson(ModelSejarahwan data) => json.encode(data.toJson());

class ModelSejarahwan {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelSejarahwan({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelSejarahwan.fromJson(Map<String, dynamic> json) => ModelSejarahwan(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String namaSejarah;
    String fotoSejarah;
    DateTime tanggalLahir;
    String asal;
    String jenisKelamin;
    String deskripsi;

    Datum({
        required this.id,
        required this.namaSejarah,
        required this.fotoSejarah,
        required this.tanggalLahir,
        required this.asal,
        required this.jenisKelamin,
        required this.deskripsi,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        namaSejarah: json["nama_sejarah"],
        fotoSejarah: json["foto_sejarah"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        asal: json["asal"],
        jenisKelamin: json["jenis_kelamin"]!,
        deskripsi: json["deskripsi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_sejarah": namaSejarah,
        "foto_sejarah": fotoSejarah,
        "tanggal_lahir": tanggalLahir.toString(),
        "asal": asal,
        "jenis_kelamin": jenisKelamin,
        "deskripsi": deskripsi,
    };
}
