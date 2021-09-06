// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

Map<String, dynamic> productModelToJsonNode(ProductModel data) => data.toJson();

class ProductModel {
    ProductModel({
        this.pkProduct = 0,
        this.fkUser = 0,
        required this.nameProduct,
        required this.priceProduct,
        this.urlImg = '',
        required this.statusRegister,
    });

    int? pkProduct;
    int? fkUser;
    String nameProduct;
    double priceProduct;
    String? urlImg;
    bool statusRegister;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        pkProduct: json["pkProduct"] as int,
        fkUser: json["fkUser"],
        nameProduct: json["nameProduct"],
        priceProduct: json["priceProduct"].toDouble(),
        urlImg: json["urlImg"],
        statusRegister: json["statusRegister"],
    );

    Map<String, dynamic> toJson() => {
        "pkProduct": pkProduct,
        "fkUser": fkUser,
        "nameProduct": nameProduct,
        "priceProduct": priceProduct,
        "urlImg": urlImg,
        "statusRegister": statusRegister,
    };
}
