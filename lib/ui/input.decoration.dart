import 'package:flutter/material.dart';

class UiDecoration {
  
  static InputDecoration authDecoration({ required String labelText, IconData ?prefixIcon }) {
    return InputDecoration(
      icon: prefixIcon != null ? Icon( prefixIcon, color: Colors.deepPurple, ) : null,
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.deepPurple
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
        )
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
          width: 2.0
        )
      )
    );
  }

  static InputDecoration singDecoration({ required String labelText }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.deepPurple
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
        )
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
          width: 2.0
        )
      )
    );
  }

}