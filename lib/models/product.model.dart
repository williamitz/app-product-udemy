// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'dart:convert';

class ProductModel {
    ProductModel({
        this.pkProduct,
        required this.nameProduct,
        required this.priceProduct,
        this.urlImg,
        required this.statusRegister,
    });

    int? pkProduct;
    String nameProduct;
    double priceProduct;
    String? urlImg;
    bool statusRegister;

    factory ProductModel.fromJson(String str) => ProductModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());
    Map<String, String> toJsonNode() => toMapNode();

    factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        pkProduct: json["pkProduct"],
        nameProduct: json["nameProduct"],
        priceProduct: json["priceProduct"].toDouble(),
        urlImg: json["urlImg"],
        statusRegister: json["statusRegister"] == 1 ? true: false,
    );

    Map<String, dynamic> toMap() => {
        "pkProduct": pkProduct,
        "nameProduct": nameProduct,
        "priceProduct": priceProduct,
        "urlImg": urlImg,
        "statusRegister": statusRegister,
    };

    Map<String, String> toMapNode() => {
        "pkProduct": pkProduct.toString(),
        "nameProduct": nameProduct,
        "priceProduct": priceProduct.toString(),
        "urlImg": urlImg ?? '',
        "statusRegister": statusRegister.toString(),
    };
}
