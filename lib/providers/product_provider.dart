import 'package:flutter/material.dart';
import 'package:product_app/models/product.model.dart';
import 'package:product_app/services/product.service.dart';

class ProductProvider extends ChangeNotifier {
  
  final List<ProductModel> listProduct = [];

  final proSvc = ProductService();

  bool loading = false;
  bool loadData = false;
  ProductModel data = ProductModel(nameProduct: '', priceProduct: 0, statusRegister: true);
  
  ProductProvider() {
    this.onGetProducts();
  }

  void onLoadData( ProductModel rec ) {
    this.loadData = true;
    data = rec;
  }

  void onReset() {
    this.loadData = false;
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
      final productTemp = ProductModel(nameProduct: el['nameProduct'] ?? ''
                                      , priceProduct: el['priceProduct']
                                      , statusRegister: el['statusRegister'] );   
      productTemp.pkProduct = el['pkProduct'] as int;

      productTemp.urlImg = el['urlImg'] ;
      this.listProduct.add( productTemp );
      
    });

    this.loading = false;
    notifyListeners();
    // print(this.listProduct[0].urlImg);
    return this.listProduct;
  }

  Future<Map<String, dynamic>> onAdd( ProductModel body ) async {
    
    final res = await proSvc.onAddProduct(body);
    final showError = int.parse(res['showError'] ?? 0);

    if (res['ok'] && showError == 0) {
      body.pkProduct = int.parse(res['data'].pk ?? 0);
      this.listProduct.add(body);
      notifyListeners();
    } 
    
    return res;
  }

  Future<Map<String, dynamic>> onUpdate( ProductModel body ) async {
    
    final res = await proSvc.onUpdateProduct(body);
    final showError = int.parse(res['showError'] ?? 0) ;

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