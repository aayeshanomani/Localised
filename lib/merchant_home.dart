import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'chatroom.dart';
import 'constants.dart';
import 'database.dart';
import 'loading.dart';
import 'payment.dart';
import 'profile.dart';
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

  int _currentIndex = 1;

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
    //card = databaseMethods.getCardDetails(Constants.myName);
  }

  final List<StatefulWidget> tabs = [
    ChatRoom(type: 'merchant',),
    Profile(),
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

        body:  tabs[_currentIndex],

        bottomNavigationBar: BottomNavigationBar
          (
          currentIndex: _currentIndex,
          //iconSize: 30.0,
          backgroundColor: Colors.redAccent,
          items: [
            BottomNavigationBarItem
            (
              icon: Icon
              (
                FontAwesomeIcons.shoppingBasket,
                color: Colors.white,
                size: _currentIndex == 0 ? 20 : 25,
              ),
              title: Text
              (
                'Chat',
                style: TextStyle(color: _currentIndex == 0 ? Colors.white : Colors.transparent),
              ),
              backgroundColor: Colors.redAccent,
            ),
            BottomNavigationBarItem
            (
              icon: Icon
              (
                FontAwesomeIcons.personBooth,
                color: Colors.white,
                size: _currentIndex == 1 ? 20 : 25,
              ),
              title: Text
              (
                'Settings',
                style: TextStyle(color: _currentIndex == 1 ? Colors.white : Colors.transparent),
              ),
              backgroundColor: Colors.redAccent,
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