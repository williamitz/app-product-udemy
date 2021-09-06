import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}