import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'customer_home.dart';
import 'customer_signin.dart';
import 'merchant_signin.dart';
import 'user.dart';
import 'utils/colors.dart';
import 'utils/utils.dart';
import 'package:provider/provider.dart';


class Choice extends StatefulWidget {
  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {

  String type = "";
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.red[900]),
    );

    final logo = Container(
      height: 200.0,
      width: 200.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AvailableImages.appLogo,
          fit: BoxFit.cover,
        ),
      ),
    );

    final appName = Column(
      children: <Widget>[
        Text(
          AppConfig.appName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
            fontSize: 60.0,
            fontFamily: 'Girassol'
          ),
        ),
        Text(
          AppConfig.appTagline,
          style: TextStyle(
              color: Colors.redAccent,
              fontSize: 18.0,
              fontWeight: FontWeight.w500
          ),
        )
      ],
    );

    final loginBtn = InkWell(
      onTap: ()
      {
        setState(() {
          type = "customer";
        });
      },
      child: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(color: Colors.redAccent),
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            'LOG IN AS CUSTOMER',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );

    final registerBtn = Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.redAccent,
      ),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: ()
        {
          setState(() {
            type = "merchant";
          });
        },
        color: Colors.redAccent,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(7.0),
        ),
        child: Text(
          'LOGIN AS MERCHANT',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
            color: Colors.white
          ),
        ),
      ),
    );

    final buttons = Padding(
      padding: EdgeInsets.only(
        top: 80.0,
        bottom: 30.0,
        left: 30.0,
        right: 30.0,
      ),
      child: Column(
        children: <Widget>[loginBtn, SizedBox(height: 20.0), registerBtn],
      ),
    );

    if(type == "customer")
    {
      return Cust_SignIn();
    }
    if(type == "merchant")
    {
      return MerchantSignIn();
    }

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 70.0),
              decoration: BoxDecoration(gradient: primaryGradient),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[logo, appName, buttons],
              ),
            ),
          ],
        ),
      ),
    );
  }
}