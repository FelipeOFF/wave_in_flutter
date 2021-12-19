import 'package:flutter/material.dart';

class BlueGradient extends StatelessWidget {
  const BlueGradient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,

              colors: [
                Colors.blue,
                Color(0xff073763),
              ]
          )
      ),
    );
  }
}