import 'package:flutter/material.dart';
import 'package:product_app/models/singin.model.dart';
import 'package:product_app/services/user.service.dart';

class SinginProvider with ChangeNotifier {
  // SinginModel

  // String fullname = '';
  GlobalKey<FormState> singinFrmKey = new GlobalKey<FormState>();

  final singinModel = SinginModel();
  final userSvc = UserService();

  bool _showPsw = false;
  
  bool isValid() => singinFrmKey.currentState?.validate() ?? false;

  bool get showPsw => _showPsw;

  set showPsw( bool val ) {
     _showPsw = val;
     notifyListeners();
  }

  Future<Map<String, dynamic>> onCreateAccount() async {
    final res = await userSvc.onSingin( singinModel );

    print('respues viernes$res');
    return res;
  }

}