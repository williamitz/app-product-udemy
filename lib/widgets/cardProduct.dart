import 'package:flutter/material.dart';
import 'package:product_app/environments/environment.dart';
import 'package:product_app/models/product.model.dart';

class CardProduct extends StatelessWidget {

  final ProductModel product;

  const CardProduct({Key? key
  , required this.product}) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 40),
        width: double.infinity,
        height: 400,
        decoration: _cardDecoration(),
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            _Backgroundw( url: product.urlImg ?? '' ),

            _BoxDetail( product: product ),
            
            _BoxPrice( product: product ),

            if( !product.statusRegister )
              _BoxStatus(  )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          offset: Offset(1, 5)
        )
      ]
  );
}

class _BoxStatus extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: 120,
        height: 50.0,
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            'No disponible',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.red[500],
          borderRadius: BorderRadius.only( 
            bottomRight: Radius.circular(25),
            topLeft: Radius.circular(25) 
          ),
        ),
      )
    );
  }
}

class _BoxPrice extends StatelessWidget {
  
  final ProductModel product;

  _BoxPrice({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.only( 
          bottomLeft: Radius.circular(25),
          topRight: Radius.circular(25) 
        ),
        child: Container(
          width: 100.0,
          height: 50.0,
          color: Colors.indigo,
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'S/ ${product.priceProduct}', 
              style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold )
            ),
          ),
        ),
      ),
    );
  }
}

class _BoxDetail extends StatelessWidget {

  final ProductModel product;

  const _BoxDetail({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(right: 100),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
        width: double.infinity,
        height: 70.0,
        decoration: _detailsDecoration(),
        // alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.nameProduct,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Id: ${product.pkProduct}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              )
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _detailsDecoration() {
    return BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only( 
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25)
        ),
      );
  }
}

class _Backgroundw extends StatelessWidget {

  final String url;
  final _path = 'http://$urlServer/file';

  _Backgroundw({Key? key, required this.url}) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: 
          url == '' 
          ? Image(
              image: AssetImage('assets/no-image.png'),
              fit: BoxFit.cover,
            )
          :
            FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'),
              image: NetworkImage('$_path/$url'),
              fit: BoxFit.cover
            )
      ),
    );
  }
}