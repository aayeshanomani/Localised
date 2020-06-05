import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'model_userlocation.dart';

class MerchHome extends StatefulWidget {
  @override
  _MerchHomeState createState() => _MerchHomeState();
}

class _MerchHomeState extends State<MerchHome> {

  Auth _auth = Auth();

  @override
  Widget build(BuildContext context) 
  {

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

      body: Center
      (
        child: Text('home'),
      )
    );
  }
}