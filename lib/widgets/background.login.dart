import 'package:flutter/material.dart';

class BackgroundLogin extends StatelessWidget {

  final Widget child;

  const BackgroundLogin({
    Key ?key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleContainer(),

          _HeaderIcon(),

          child
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 25.0),
        child: Icon( Icons.person_pin, size: 100.0, color: Colors.white, ),
      ),
    );
  }
}

class _PurpleContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    return Container(
      
      width: double.infinity,
      height: _size.height * 0.4,
      decoration: _buildDecoration(),
      child: Stack(
        children: [
          Positioned(
            child: _Bubble(width: 100.0, height: 100.0,),
            top: 0.5,
            left: -5.0,
          ),
          Positioned(
            child: _Bubble(width: 170.0, height: 170.0,),
            top: 20.5,
            right: 1.0,
          ),
          Positioned(
            child: _Bubble(width: 100.0, height: 100.0,),
            bottom: -50.0,
            left: 50.0,
          ),
          Positioned(
            child: _Bubble(width: 50.0, height: 50.0,),
            top: 150.5,
            left: _size.width * 0.42,
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildDecoration() => BoxDecoration(
    color: Colors.deepPurple,
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1),
      ]
    )
  );

  
}

class _Bubble extends StatelessWidget {

  _Bubble({ required this.width, required this.height });
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
   
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.1),
        borderRadius: BorderRadius.circular(100)
      ),
    );
  }
}