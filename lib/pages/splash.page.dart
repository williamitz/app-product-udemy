import 'package:flutter/material.dart';
import 'package:product_app/pages/pages.module.dart';
import 'package:product_app/services/storage.service.dart';

class SplashPage extends StatelessWidget {
  // const SplashPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _st = StorageService();

    return Scaffold(
      body: FutureBuilder(
        future: _st.onLoadToken(),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator(),);
          }

          if (snapshot.data == '') {
            Future.microtask(() => {
              Navigator.pushReplacement(
                context, 
                PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage(),
                transitionDuration: Duration( seconds: 0 )))
            });
          }

          if (snapshot.data != '') {
            Future.microtask(() => {
              Navigator.pushReplacement(
                context, 
                PageRouteBuilder(pageBuilder: (_, __, ___) => HomePage(),
                transitionDuration: Duration( seconds: 0 )))
            });
          }

          return Container();

        },
      ),
    );
  }
}