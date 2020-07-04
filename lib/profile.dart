import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localised/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
      (
        title: Text('Profile',
        style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        actions: <Widget>
        [
          FlatButton.icon
          (
            icon: Icon
            (
              FontAwesomeIcons.lockOpen,
              color: Colors.white,
            ),
            label: Text
            (
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async
            {
              await _auth.signOut();
            },
          )
        ],
      ),

      body: Container
      (

      ),
    );
  }
}