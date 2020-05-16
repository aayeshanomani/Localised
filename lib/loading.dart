import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[300],
      child: Center
      (
        child: SpinKitWanderingCubes
        (
          color: Colors.lightBlue[900],
          size: 50.0,
        ),
      )
    );
  }
}