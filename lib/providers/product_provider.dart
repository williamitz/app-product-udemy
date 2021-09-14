import 'dart:io';

import 'package:flutter/material.dart';
import 'package:product_app/models/product.model.dart';
import 'package:product_app/services/product.service.dart';
import 'dart:async';

class ProductProvider extends ChangeNotifier {
  
  final List<ProductModel> listProduct = [];

  final proSvc = ProductService();

  File? fileTemp;

  bool loading = false;
  bool loadData = false;
  ProductModel data = ProductModel(nameProduct: '', priceProduct: 0.0, statusRegister: true);
  
  ProductProvider() {
    this.onGetProducts();
  }

  void onLoadData( ProductModel rec ) {
    this.loadData       = true;
    data.pkProduct      = rec.pkProduct;
    data.priceProduct   = rec.priceProduct;
    data.statusRegister = rec.statusRegister;
    data.nameProduct    = rec.nameProduct;
    data.urlImg         = rec.urlImg;
  }

  void onReset() {
    this.loadData = false;
    this.data.urlImg = '';
  }

  Future<List<ProductModel>> onGetProducts() async {

    this.loading = true;
    notifyListeners();

    final res = await this.proSvc.onGetList();

    if (!res['ok']) {
      print('Error al listar products: ${res['error']}');
    }

    final List<dynamic> data = res['data'] ?? [];

    data.forEach((el) {
      
      // final eltemp = productModelFromJson( el.toString() );
      final productTemp = ProductModel.fromMap(el);   
      // productTemp.pkProduct = el['pkProduct'] as int;

      // productTemp.urlImg = el['urlImg'] ;
      this.listProduct.add( productTemp );
      
    });

    this.loading = false;
    notifyListeners();
    // print(this.listProduct[0].urlImg);
    return this.listProduct;
  }

  void onSelectedFile( String path ) {
    
    this.fileTemp = File.fromUri( Uri.file(path) );
    this.data.urlImg = path;

    notifyListeners();

  }

  Future<Map<String, dynamic>> onAdd( ProductModel body ) async {
    
    final res = await proSvc.onAddProduct(body);
    print('response post: $res');
    final showError = res['showError'] ?? 0;

    if (res['ok'] && showError == 0) {
      body.pkProduct = res['pk'] ?? 0;
      this.listProduct.add(body);
      notifyListeners();
    } 
    
    return res;
  }

  Future<Map<String, dynamic>> onUpdate( ProductModel body ) async {
    
    final res = await proSvc.onUpdateProduct(body);
    print('response: $res');
    final showError = res['showError'] ?? 0 ;

    if (res['ok'] && showError == 0) {
      final index = this.listProduct.indexWhere((e) => e.pkProduct == body.pkProduct);
      this.listProduct[index].nameProduct = body.nameProduct;
      this.listProduct[index].priceProduct = body.priceProduct;
      this.listProduct[index].statusRegister = body.statusRegister;
      notifyListeners();
    } 
    
    return res;
  }

}