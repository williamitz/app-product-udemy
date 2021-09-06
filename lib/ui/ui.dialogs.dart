import 'package:flutter/material.dart';

class Loadingw extends StatelessWidget {
  // const Loading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Espere...'),
          SizedBox(height: 10.0,),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}

class Alertw extends StatelessWidget {

  final IconData iconAlert;
  final String message;

  const Alertw({ Key ?key, required this.iconAlert, required this.message }) 
  : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: AlertDialog(
        title: ListTile(
          leading: Icon( iconAlert, color: Colors.deepPurple, ),
          title: Text('Mensaje al usuario'),
        ),
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text( message ),
        ),
        actions: [
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}