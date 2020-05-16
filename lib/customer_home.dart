import 'package:flutter/material.dart';
import 'package:localised/auth.dart';

import 'package:geolocator/geolocator.dart';

class 
CustomerHome extends StatelessWidget {

  final Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      backgroundColor: Colors.indigoAccent[400],
      appBar: AppBar
      (
        title: Text('Home',
        style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.lightBlue[50],
        elevation: 0.0,
        actions: <Widget>
        [
          FlatButton.icon
          (
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async
            {
              await _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}