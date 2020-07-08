import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localised/chatroom.dart';
import 'package:localised/constants.dart';
import 'package:localised/database.dart';
import 'package:localised/helper.dart';

import 'package:localised/loading.dart';
import 'package:localised/model_userlocation.dart';
import 'package:localised/profile.dart';
import 'package:localised/searchview.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'mapview.dart';

class CustomerHome extends StatefulWidget {
  @override
  CustomerHomeState createState() => CustomerHomeState();
}

class CustomerHomeState extends State<CustomerHome> {

  int currentIndex = 0;
  Auth _auth = Auth();

  final List<StatefulWidget> tabs = [
      MapView(),
      SearchView(),
      ChatRoom(type: 'customer',),
      Profile(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    super.initState();
  }

  getUserInfo() async
  {
    Constants.myName = await HelperFunc.getUsername();
    print(Constants.myName);
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.redAccent),
    );
    
    var userLocation = Provider.of<UserLocation>(context);
    return userLocation == null ? Loading() : Scaffold
    (
      backgroundColor: Colors.black,
      /*appBar: AppBar
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
      ),*/

      body: tabs[currentIndex],

      bottomNavigationBar: BottomNavigationBar
      (
        currentIndex: currentIndex,
        //iconSize: 30.0,
        elevation: 2.0,

        items: [
          BottomNavigationBarItem
          (
            icon: Icon
            (
              FontAwesomeIcons.mapMarkedAlt,
              color: Colors.white,
            ),
            title: Text
            (
              'Near You',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem
          (
            icon: Icon
            (
              FontAwesomeIcons.searchLocation,
              color: Colors.white,
            ),
            title: Text
            (
              'Search',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem
          (
            icon: Icon
            (
              FontAwesomeIcons.shoppingBasket,
              color: Colors.white,
            ),
            title: Text
            (
              'Chat',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem
          (
            icon: Icon
            (
              FontAwesomeIcons.personBooth,
              color: Colors.white,
            ),
            title: Text
            (
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent,
          )
        ],
        onTap: (index)
        {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

