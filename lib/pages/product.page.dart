import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';

import 'package:product_app/providers/frm_product.provider.dart';
import 'package:product_app/ui/ui.dialogs.dart';

import 'package:product_app/providers/product_provider.dart';
import 'package:product_app/ui/input.decoration.dart';
import 'package:product_app/widgets/widgets.module.dart';

class ProductPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final producP = Provider.of<ProductProvider>(context);
    // producP.onGetProducts();
    return ChangeNotifierProvider(
      create: (BuildContext context) => FrmProductProvider( producP.data, producP.loadData) ,
      child: _ContentFrmProduct(producP: producP),
    );
  }
}

class _ContentFrmProduct extends StatelessWidget {
  _ContentFrmProduct({
    Key? key,
    required this.producP,
  }) : super(key: key);

  final ProductProvider producP;

  @override
  Widget build(BuildContext context) {

    final _frmProvider = Provider.of<FrmProductProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
      
            Stack(
              children: [
                ImgProduct( urlImg: producP.data.urlImg ?? '' ),
      
                Positioned(
                  top: 70.0,
                  left: 25.0,
                  child: IconButton(
                    onPressed: () {
                      producP.onReset();
                      // frmProductp.onReset();
                      Navigator.of(context).pop();
                    }, 
                    icon: Icon( Icons.arrow_back_ios, size: 40, color: Colors.white, )
                  ),
                ),
      
                Positioned(
                  top: 70.0,
                  right: 25.0,
                  child: IconButton(
                    onPressed: () async {
                      final _picker = ImagePicker();
                      final XFile? _picked = await _picker.pickImage(source: ImageSource.gallery );

                      if (_picked != null) {
                        producP.onSelectedFile( _picked.path );
                      }

                    }, 
                    icon: Icon( Icons.camera_alt_outlined, size: 40, color: Colors.white, )
                  ),
                )
              ],
            ),
      
            _ProductForm( ),
      
            SizedBox(height: 100)
      
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(

        onPressed: _frmProvider.validFrm == false
        ? null
        : () async {

          _showLoading( context );

          final res = _frmProvider.loadData 
          ? await producP.onUpdate( _frmProvider.body )
          : await producP.onAdd( _frmProvider.body );

          final showError = res['showError'] ?? 0;
          final text = _getError(showError);

          Navigator.of(context).pop();

          if (showError != 0) {
            return _showAlert( context, text );
          }

          Navigator.of(context).pop();

        },
        child: Icon( Icons.save_outlined ),
      ),
    );
  }

  String _getError( int showError ) {
    List<String> error = showError == 0 ? ['Bienvenido'] : ['Alerta'];

    if (showError == 1) {
      error.add('(Usuario) o contraseña incorrectos');
    }

    if (showError == 2) {
      error.add('Usuario o (contraseña) incorrectos');
    }

    return error.join(', ');
  }

  _showLoading( BuildContext context ) {
    showDialog(
      context: context,
      builder: (context) => Loadingw()
    );
  }

  _showAlert( BuildContext context, String text ) {
    showDialog(
      context: context, 
      builder: (context) => Alertw(iconAlert: Icons.warning , message: text)
    );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final frmProductp = Provider.of<FrmProductProvider>(context);
    final body = frmProductp.body;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        // height: 200.0,
        decoration: _boxDecorationFrm(),
        child: Form(
          key: frmProductp.frmProduct,
          autovalidateMode: AutovalidateMode.onUserInteraction ,
          child: Column(
            children: [
              SizedBox( height: 30, ),
              TextFormField(
                decoration: UiDecoration.authDecoration(labelText: 'Nombre'),
                initialValue: body.nameProduct,
                validator: (value) {
                  if (value == null || value.length < 3) {
                    return 'El nombre es requerido';
                  }
                },
                onChanged: (value) {
                  body.nameProduct = value;
                  frmProductp.onValidFrm();
                }
              ),

              SizedBox( height: 20, ),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: UiDecoration.authDecoration(labelText: 'Precio'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                initialValue: body.priceProduct.toString(),
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    body.priceProduct = 0;
                  } else {
                    body.priceProduct = double.parse(value);
                  }
                  frmProductp.onValidFrm();
                },

              ),
              SizedBox( height: 20, ),

              SwitchListTile.adaptive(
                value: body.statusRegister,
                title: Text('Disponible?'),
                onChanged: frmProductp.onChangeStatus
              ),

              SizedBox( height: 30, ),
              
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _boxDecorationFrm() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only( 
      bottomLeft: Radius.circular(25), 
      bottomRight: Radius.circular(25) 
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 5,
        offset: Offset(0, 5)
      )
    ]
  );
}