import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'chatroom.dart';

class NewLoading extends StatefulWidget {
  @override
  _NewLoadingState createState() => _NewLoadingState();
}

class _NewLoadingState extends State<NewLoading> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), ()
    {
      Navigator.pushReplacement(context, MaterialPageRoute
          (
            builder: (context) => ChatRoom()
        ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[300],
      child: Center
      (
        child: SpinKitSquareCircle
        (
          color: Colors.lightBlue[900],
          size: 50.0,
        ),
      )
    );
  }
}