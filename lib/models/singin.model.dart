// To parse this JSON data, do
//
//     final singinModel = singinModelFromJson(jsonString);

import 'dart:convert';

SinginModel singinModelFromJson(String str) => SinginModel.fromJson(json.decode(str));
String singinModelToJson(SinginModel data) => json.encode(data.toJson());
Map<String, dynamic> singinModelToJsonNode(SinginModel data) => data.toJson();

class SinginModel {
    SinginModel({
        this.fullname = '',
        this.email = '',
        this.phone = '',
        this.userPassword = '',
        this.confirmPassword = '',
    });

    String fullname;
    String email;
    String phone;
    String userPassword;
    String confirmPassword;

    factory SinginModel.fromJson(Map<String, dynamic> json) => SinginModel(
        fullname: json["fullname"],
        email: json["email"],
        phone: json["phone"],
        userPassword: json["userPassword"],
    );

    Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "userPassword": userPassword,
    };

    void onReset() {
      this.fullname = '';
      this.email = '';
      this.phone = '';
      this.userPassword = '';
      this.confirmPassword = '';
    }
}
