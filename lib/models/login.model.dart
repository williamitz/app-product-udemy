// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());
Map<String, dynamic> loginModelToJsonNode(LoginModel data) => data.toJson();

class LoginModel {
    LoginModel({
        this.userName = '',
        this.userPassword = '',
    });

    String userName;
    String userPassword;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        userName: json["userName"],
        userPassword: json["userPassword"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "userPassword": userPassword,
    };
}
