import 'package:flutter/material.dart';
import 'package:localised/authenticate.dart';
import 'package:localised/customer_signin.dart';

class Choice extends StatefulWidget {
  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Cust_SignIn();
                  }));
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

                },
              )
            ],
          ),
        ),
      )
    );
  }
}