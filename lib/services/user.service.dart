import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:product_app/environments/environment.dart';
import 'package:product_app/models/login.model.dart';
import 'package:product_app/models/singin.model.dart';

class UserService {

  Future<Map<String, dynamic>> onSingin( SinginModel body ) async {
    final endPoint = Uri.http( urlServer, '/Singin');

    final response = await http.post(endPoint, body: singinModelToJsonNode( body ), headers: {} );

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    }    
    return { "ok": false, "error": response };
  }

  Future<Map<String, dynamic>> onLogin( LoginModel body ) async {
    final endPoint = Uri.http( urlServer, '/Login');

    final response = await http.post(endPoint, body: loginModelToJsonNode( body ), headers: {} );

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    }    
    return { "ok": false, "error": response };
  }
  
}