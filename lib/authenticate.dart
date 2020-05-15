import 'package:flutter/material.dart';
import 'package:localised/customer_register.dart';
import 'package:localised/customer_signin.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView()
  {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn)
    {
      return Cust_SignIn(toggleView: toggleView);
    }
    else
    {
      return CustRegister(toggleView: toggleView);
    }
  }
}
