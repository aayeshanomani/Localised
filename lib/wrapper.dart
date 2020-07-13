import 'package:Localised/payment.dart';
import 'package:Localised/showpay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'choice.dart';
import 'customer_home.dart';
import 'merchant_home.dart';
import 'model_userlocation.dart';
import 'newloading.dart';
import 'onboarding.dart';
import 'service_location.dart';
import 'user.dart';
import 'package:provider/provider.dart';

import 'helper.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool userLog;

  FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    getLoggedInInfo();
    super.initState();
  }

  getLoggedInInfo() async {
    await HelperFunc.getUserloggedIn().then((value) {
      setState(() {
        userLog = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String type = "";

    /*if(userLog == null)
      {
        return Choice();
      }*/
    //return either home or authenticate
    if (user == null) {
      return StreamProvider<UserLocation>(
        //builder: (context) => LocationService().locationStream,
        create: (BuildContext context) => LocationService().locationStream,
        child: Choice(),
      );
    } else {
      var uid = user.uid;
      final CollectionReference type =
          Firestore.instance.collection('locations');
      return StreamBuilder(
          stream: Firestore.instance.collection('locations').snapshots(),
          builder: (context, snapshot) {
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              if (snapshot.data.documents[i]['type'] == 'customer' &&
                  snapshot.data.documents[i]['id'] == user.uid) {
                return StreamProvider<UserLocation>(
                  //builder: (context) => LocationService().locationStream,
                  create: (BuildContext context) =>
                      LocationService().locationStream,
                  child: CustomerHome(),
                );
              } else if (snapshot.data.documents[i]['type'] == 'merchant' &&
                  snapshot.data.documents[i]['id'] == user.uid) {
                    if (snapshot.data.documents[i]['payment'] == true
                    &&
                    int.parse(snapshot.data.documents[i]['expDate'])>DateTime.now().millisecondsSinceEpoch) {
                      return StreamProvider<UserLocation>(
                        //builder: (context) => LocationService().locationStream,
                        create: (BuildContext context) =>
                            LocationService().locationStream,
                        child: MerchHome(),
                      );
                    } else {
                      return StreamProvider<UserLocation>(
                        //builder: (context) => LocationService().locationStream,
                        create: (BuildContext context) =>
                            LocationService().locationStream,
                        child: ShowPay(),
                      );
                    }
              }
            }
            return null;
          });
    }
  }
}
