import 'package:flutter/cupertino.dart';
import 'package:product_app/models/product.model.dart';

class FrmProductProvider extends ChangeNotifier {

  final GlobalKey<FormState> frmProduct = new GlobalKey<FormState>();
  bool loadData = false;
  bool validFrm = false;
  // bool loading = false;
  // late ProductModel data;
  ProductModel body = ProductModel(nameProduct: '', priceProduct: 0, statusRegister: true);

  FrmProductProvider( ProductModel? rec, bool loadData ) {

    this.loadData = loadData;
    // this.data = rec;

    if (loadData && rec != null) {
      
      this.body.pkProduct = rec.pkProduct;
      this.body.nameProduct = rec.nameProduct;
      this.body.priceProduct = rec.priceProduct;
      this.body.statusRegister = rec.statusRegister;
      this.body.urlImg = rec.urlImg;
    }else {
      this.body.pkProduct = 0;
      this.body.nameProduct = '';
      this.body.priceProduct = 0;
      this.body.statusRegister = true;
      this.body.urlImg = null;
    }
  }

  void onReset() {
    this.loadData = false;
  }

  onValidFrm() {

    this.validFrm = this.frmProduct.currentState?.validate() ?? false;
    notifyListeners();

  }

  onChangeStatus( bool value ) {
    this.body.statusRegister = value;
    notifyListeners();
  }
  
}