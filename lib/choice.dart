import 'package:flutter/material.dart';
import 'package:localised/customer_home.dart';
import 'package:localised/customer_signin.dart';
import 'package:localised/merchant_authenticate.dart';
import 'package:localised/merchant_register.dart';
import 'package:localised/user.dart';
import 'package:provider/provider.dart';

import 'customer_authenticate.dart';

class Choice extends StatefulWidget {
  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {

  String type = "";
  @override
  Widget build(BuildContext context) {

    if(type == "customer")
    {
      return CustAuthenticate();
    }
    if(type == "merchant")
    {
      return MerchAuthenticate();
    }

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Container
      (
        padding: EdgeInsets.symmetric(vertical:300.0, horizontal:50.0),
        child: Center
        (
          child: Column
          (
            children: <Widget>
            [
              SizedBox(height: 20.0,),
              RaisedButton
              (
                color: Colors.indigoAccent,
                child: Text
                (
                  'Sign in as Customer',
                  style: TextStyle(color: Colors.lightBlue[200]),
                ),
                onPressed: ()
                {
                  setState(() {
                    type = "customer";
                  });
                  //Navigator.push(context, MaterialPageRoute(builder: (context){
                    //return CustAuthenticate();
                  //}));
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton
              (
                color: Colors.indigoAccent,
                child: Text
                (
                  'Sign in as Merchant',
                  style: TextStyle(color: Colors.lightBlue[200]),
                ),
                onPressed: ()
                {
                  setState(() {
                    type = "merchant";
                  });
                },
              )
            ],
          ),
        ),
      )
    );
  }
}