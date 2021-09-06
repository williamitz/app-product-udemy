import 'package:flutter/material.dart';
import 'package:product_app/pages/pages.module.dart';
import 'package:product_app/providers/product_provider.dart';
import 'package:product_app/widgets/cardProduct.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final producP = Provider.of<ProductProvider>(context);
    
    if (producP.loading) {
      return LoadingPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),

      body: ListView.builder(
        itemCount: producP.listProduct.length,
        itemBuilder: (BuildContext context, int index) {
          print('http://192.168.0.160/file/${ producP.listProduct[index].urlImg }');
        return GestureDetector(
          child: CardProduct( product: producP.listProduct[index]),
          onTap: () {
            producP.onLoadData(producP.listProduct[index]);
            Navigator.pushNamed(context, 'product');
          },
        );
       },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
        onPressed: () {
          producP.onReset();
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}