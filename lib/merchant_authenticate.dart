import 'package:flutter/material.dart';
import 'package:localised/customer_register.dart';
import 'package:localised/customer_signin.dart';
import 'package:localised/merchant_register.dart';
import 'package:localised/merchant_signin.dart';

class MerchAuthenticate extends StatefulWidget {
  @override
  _MerchAuthenticateState createState() => _MerchAuthenticateState();
}

class _MerchAuthenticateState extends State<MerchAuthenticate> {

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
      return MerchantSignIn(toggleView: toggleView);
    }
    else
    {
      return MerchRegister(toggleView: toggleView);
    }
  }
}
