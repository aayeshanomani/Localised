import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localised/choice.dart';
import 'package:localised/customer_home.dart';
import 'package:localised/merchant_home.dart';
import 'package:localised/model_userlocation.dart';
import 'package:localised/service_location.dart';
import 'package:localised/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    String type = "";
    
    //return either home or authenticate
    if(user == null)
    {
      return StreamProvider<UserLocation>
      (
        //builder: (context) => LocationService().locationStream,
        create: (BuildContext context) => LocationService().locationStream,
        child: Choice(),
      );
    }
    else
    {
      var uid = user.uid;
      final CollectionReference type = Firestore.instance.collection('locations');
      return StreamBuilder
      (
        stream: Firestore.instance.collection('locations').snapshots(),
        builder: (context, snapshot)
        {
          for(int i=0; i<snapshot.data.documents.length; i++)
          {
            if(snapshot.data.documents[i]['type']=='customer' && snapshot.data.documents[i]['id'] == user.uid)
            {
              return StreamProvider<UserLocation>
              (
                //builder: (context) => LocationService().locationStream,
                create: (BuildContext context) => LocationService().locationStream,
                child: CustomerHome(),
              );
            }
            else if(snapshot.data.documents[i]['type']=='merchant' && snapshot.data.documents[i]['id'] == user.uid)
            {
              return StreamProvider<UserLocation>
              (
                //builder: (context) => LocationService().locationStream,
                create: (BuildContext context) => LocationService().locationStream,
                child: MerchHome(),
              );
            }
          }
        }
      );
      
      
    }
  }
}