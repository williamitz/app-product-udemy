import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:product_app/environments/environment.dart';
import 'package:product_app/models/product.model.dart';
import 'package:product_app/services/storage.service.dart';

class ProductService {

  final st = StorageService();

  Future<Map<String, dynamic>> onGetList() async {
    final endPoint = Uri.http( urlServer, '/Product');

    final response = await http.get(endPoint, headers: { 'Authorization': st.token } );

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    }    
    return { "ok": false, "error": response };
  }

  Future<Map<String, dynamic>> onAddProduct( ProductModel body ) async {
    final endPoint = Uri.http( urlServer, '/Product');

    final response = await http.post(endPoint , body: productModelToJsonNode( body ) , headers: { 'Authorization': st.token } );

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    }    
    return { "ok": false, "error": response };
  }

  Future<Map<String, dynamic>> onUpdateProduct( ProductModel body ) async {

    print('product pk ${body.pkProduct}');
    print('product name ${body.nameProduct}');
    print('product price ${body.priceProduct}');
    print('product status ${body.statusRegister}');
    print('product img ${body.urlImg}');
    print('product fk ${body.fkUser}');

    final endPoint = Uri.http( urlServer, '/Product/${body.pkProduct ?? 0}');

    final response = await http.put(endPoint
            , body: productModelToJsonNode( body )
            , headers: { 'Authorization': st.token } );

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    }    
    return { "ok": false, "error": response };
  }
  
}