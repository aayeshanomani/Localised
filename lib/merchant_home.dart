import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localised/chatroom.dart';
import 'package:localised/constants.dart';
import 'package:localised/database.dart';
import 'package:localised/loading.dart';
import 'package:localised/payment.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'helper.dart';
import 'model_userlocation.dart';

class MerchHome extends StatefulWidget {
  @override
  _MerchHomeState createState() => _MerchHomeState();
}

class _MerchHomeState extends State<MerchHome> {

  Auth _auth = Auth();

  int _currentIndex = 0;

  Stream<QuerySnapshot> cardDetails;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  QuerySnapshot card;
  bool load;

  @override
  void initState() {
    // TODO: implement initState
    getUser();

    super.initState();
  }

  getUser() async
  {
    Constants.myName = await HelperFunc.getUsername();
    print(Constants.myName);
    card = databaseMethods.getCardDetails(Constants.myName);
  }

  final tabs = [
    ChatRoom(),
    Center(child: Text('Settings', style: TextStyle(color: Colors.blue[600]),),),
  ];

  @override
  Widget build(BuildContext context) 
  {
    //if(card == null)
      //return PaymentScreen();
    //else {
      return Scaffold
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
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      );
    //}
  }
}