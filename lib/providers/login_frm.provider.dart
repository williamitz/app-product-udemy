import 'package:flutter/material.dart';
import 'package:product_app/models/login.model.dart';
import 'package:product_app/services/user.service.dart';

class LoginFrmProvider extends ChangeNotifier {

  GlobalKey<FormState> loginFrmKey = new GlobalKey<FormState>();
  final _authSvc = UserService();

  final LoginModel _body = LoginModel();
  bool isValid = false;

  set user(String val) {
    _body.userName = val;
    isValid = loginFrmKey.currentState?.validate() ?? false;
    notifyListeners();
  }
  set password(String val) {
    _body.userPassword = val;
    isValid = loginFrmKey.currentState?.validate() ?? false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> onLogin() async{
    final res = _authSvc.onLogin( _body );
    return res;
  } 
  
}