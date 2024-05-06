// To parse this JSON data, do
//
//     final modelInsertSejarahwan = modelInsertSejarahwanFromJson(jsonString);

import 'dart:convert';

ModelInsertSejarahwan modelInsertSejarahwanFromJson(String str) => ModelInsertSejarahwan.fromJson(json.decode(str));

String modelInsertSejarahwanToJson(ModelInsertSejarahwan data) => json.encode(data.toJson());

class ModelInsertSejarahwan {
    bool isSuccess;
    String message;

    ModelInsertSejarahwan({
        required this.isSuccess,
        required this.message,
    });

    factory ModelInsertSejarahwan.fromJson(Map<String, dynamic> json) => ModelInsertSejarahwan(
        isSuccess: json["isSuccess"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
    };
}
