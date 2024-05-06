// To parse this JSON data, do
//
//     final modelDltSejarahwan = modelDltSejarahwanFromJson(jsonString);

import 'dart:convert';

ModelDltSejarahwan modelDltSejarahwanFromJson(String str) => ModelDltSejarahwan.fromJson(json.decode(str));

String modelDltSejarahwanToJson(ModelDltSejarahwan data) => json.encode(data.toJson());

class ModelDltSejarahwan {
    String status;
    String message;

    ModelDltSejarahwan({
        required this.status,
        required this.message,
    });

    factory ModelDltSejarahwan.fromJson(Map<String, dynamic> json) => ModelDltSejarahwan(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
