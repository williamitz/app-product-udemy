import 'package:flutter/material.dart';

class CardLogin extends StatelessWidget {

  final Widget child;

  const CardLogin({
    Key ?key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      decoration: _cardDecoration(),
      child: child,
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5.0,
          offset: Offset( 2.0, 1.0 ),
        )
      ]
    );
  }
}