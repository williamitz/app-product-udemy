import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:product_app/pages/pages.module.dart';
import 'package:product_app/providers/product_provider.dart';
import 'package:product_app/services/storage.service.dart';

void main() async  {
  
  WidgetsFlutterBinding.ensureInitialized();

  final st = new StorageService();
  await st.initPrefs();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  // const AppState({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider())
      ],
      child: MyApp(),
    );
  }
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final _st = StorageService();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute:  'home', // _st.token == '' ? 'login' :

      routes: {
        'login'   : (_) => LoginPage(),
        'singin'  : (_) => SinginPage(),
        'home'    : (_) => HomePage(),
        'product' : (_) => ProductPage(),
      },

      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          backgroundColor: Colors.indigo
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.indigo
        )
      ),
    );
  }
}