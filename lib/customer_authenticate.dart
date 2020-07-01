import 'package:flutter/material.dart';
import 'package:localised/customer_register.dart';
import 'package:localised/customer_signin.dart';
import 'package:provider/provider.dart';

import 'model_userlocation.dart';
import 'service_location.dart';

class CustAuthenticate extends StatefulWidget {


  @override
  _CustAuthenticateState createState() => _CustAuthenticateState();
}

class _CustAuthenticateState extends State<CustAuthenticate> {

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
      return Cust_SignIn(toggleView: toggleView,);
    }
    else
    {
      return StreamProvider<UserLocation>
      (
        //builder: (context) => LocationService().locationStream,
        create: (BuildContext context) => LocationService().locationStream,
        child: CustRegister(toggleView: toggleView,),
      );
    }
  }
}
