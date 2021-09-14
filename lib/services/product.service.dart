import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:product_app/environments/environment.dart';
import 'package:product_app/models/product.model.dart';
import 'package:product_app/services/storage.service.dart';

class ProductService {

  final st = StorageService();

  Future<Map<String, dynamic>> onGetList() async {
    final url = Uri.http( urlServer, '/Product');

    final response = await http.get(url, headers: { 'Authorization': st.token } );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }    
    return { "ok": false, "error": response };
  }

  Future<Map<String, dynamic>> onAddProduct( ProductModel body ) async {
    final endPoint = Uri.http( urlServer, '/Product');

    final response = await http.post(endPoint , body: body.toJsonNode() , headers: { 'Authorization': st.token } );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }    
    return { "ok": false, "error": response };
  }

  Future<Map<String, dynamic>> onUpdateProduct( ProductModel body ) async {


    final url = Uri.http( urlServer, '/Product/${body.pkProduct}');

    final response = await http.put(url
            , body: body.toJsonNode()
            , headers: { 'Authorization': st.token } );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }    
    return { "ok": false, "error": response };
  }
  
}