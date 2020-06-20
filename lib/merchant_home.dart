import 'package:flutter/material.dart';
import 'package:localised/chatroom.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'model_userlocation.dart';

class MerchHome extends StatefulWidget {
  @override
  _MerchHomeState createState() => _MerchHomeState();
}

class _MerchHomeState extends State<MerchHome> {

  Auth _auth = Auth();

  int _currentIndex = 0;

  final tabs = [
    ChatRoom(),
    Center(child: Text('Settings', style: TextStyle(color: Colors.blue[600]),),),
  ];

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

      body: tabs[_currentIndex],

      bottomNavigationBar: BottomNavigationBar
        (
        currentIndex: _currentIndex,
        //iconSize: 30.0,

        items: [
          BottomNavigationBarItem
            (
            icon: Icon
              (
              Icons.chat,
              color: Colors.lightBlueAccent[400],
            ),
            title: Text
              (
              'Chat',
              style: TextStyle(color: Colors.lightBlueAccent[700]),
            ),
            backgroundColor: Colors.blue[50],
          ),
          BottomNavigationBarItem
            (
            icon: Icon
              (
              Icons.border_color,
              color: Colors.lightBlueAccent[400],
            ),
            title: Text
              (
              'Edit Profile',
              style: TextStyle(color: Colors.lightBlueAccent[700]),
            ),
            backgroundColor: Colors.blue[50],
          )
        ],
        onTap: (index)
        {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}