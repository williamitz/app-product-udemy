import 'dart:io';

import 'package:flutter/material.dart';
import 'package:product_app/environments/environment.dart';
// import 'package:product_app/providers/frm_product.provider.dart';
// import 'package:provider/provider.dart';

class ImgProduct extends StatelessWidget {

  final _radius = Radius.circular(45);
  final _path = 'http://$urlServer/file';
  final String urlImg;

  ImgProduct({Key? key, required this.urlImg}) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    // final frmProductp = Provider.of<FrmProductProvider>(context);
    
    return Padding(
      padding: EdgeInsets.only( left: 10.0, top: 10.0, right: 10.0 ),
      child: Container(
        width: double.infinity,
        height: 400.0,
        decoration: _boxDecoration(),
        child: Opacity(
          opacity: 0.85,
          child: ClipRRect(
            borderRadius: BorderRadius.only( topLeft: _radius, topRight: _radius),
            child: _getImage(),
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only( topLeft: _radius, topRight: _radius),
    boxShadow: [
      BoxShadow(
        blurRadius: 10,
        color: Colors.black12,
        offset: Offset(0, 5)
      )
    ]
  );

  Widget _getImage() {
    print('urlimg: $urlImg');

    if ( urlImg == '' ) {
      return Image(
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
      );
    }

    if ( urlImg.startsWith('file') ) {
      print('$_path/$urlImg');
      return FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'), 
          image: NetworkImage('$_path/$urlImg'),
          fit: BoxFit.cover,
        );
    }

    return Image.file( File( urlImg ), fit: BoxFit.cover, );      

  }
}