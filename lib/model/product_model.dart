// To parse this JSON data, do
//
//     final modelProduct = modelProductFromJson(jsonString);

import 'dart:convert';

List<ModelProduct> modelProductFromJson(String str) => List<ModelProduct>.from(json.decode(str).map((x) => ModelProduct.fromJson(x)));

String modelProductToJson(List<ModelProduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelProduct {
    ModelProduct({
        this.intProductId,
        this.txtProductCode,
        this.txtProductName,
        this.intBrandId,
        this.dtInserted,
    });

    String intProductId;
    String txtProductCode;
    String txtProductName;
    String intBrandId;
    DateTime dtInserted;

    factory ModelProduct.fromJson(Map<String, dynamic> json) => ModelProduct(
        intProductId: json["intProductID"],
        txtProductCode: json["txtProductCode"],
        txtProductName: json["txtProductName"],
        intBrandId: json["intBrandID"],
        dtInserted: DateTime.parse(json["dtInserted"]),
    );

    Map<String, dynamic> toJson() => {
        "intProductID": intProductId,
        "txtProductCode": txtProductCode,
        "txtProductName": txtProductName,
        "intBrandID": intBrandId,
        "dtInserted": dtInserted.toIso8601String(),
    };
}
