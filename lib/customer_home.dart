import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:localised/chatstate.dart';
import 'package:localised/loading.dart';
import 'package:localised/model_userlocation.dart';
import 'package:localised/searchview.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'mapview.dart';

class CustomerHome extends StatefulWidget {
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {

  int _currentIndex = 0;
  Auth _auth = Auth();

  final tabs = [
      MapView(),
      SearchView(),
      ChatView(),
      Center(child: Text('Settings', style: TextStyle(color: Colors.blue[600]),),),
  ];

  @override
  Widget build(BuildContext context) {
    
    var userLocation = Provider.of<UserLocation>(context);
    return userLocation == null ? Loading() : Scaffold
    (
      backgroundColor: Colors.black,
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
              Icons.map,
              color: Colors.lightBlueAccent[400],
            ),
            title: Text
            (
              'Near You',
              style: TextStyle(color: Colors.lightBlueAccent[700]),
            ),
            backgroundColor: Colors.blue[50],
          ),
          BottomNavigationBarItem
          (
            icon: Icon
            (
              Icons.search,
              color: Colors.lightBlueAccent[400],
            ),
            title: Text
            (
              'Search',
              style: TextStyle(color: Colors.lightBlueAccent[700]),
            ),
            backgroundColor: Colors.blue[50],
          ),
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
              Icons.settings,
              color: Colors.lightBlueAccent[400],
            ),
            title: Text
            (
              'Settings',
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

