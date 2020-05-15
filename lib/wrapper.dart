import 'package:flutter/material.dart';
import 'package:localised/authenticate.dart';
import 'package:localised/customer_home.dart';
import 'package:localised/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    //return either home or authenticate
    if(user == null)
    {
      return Authenticate();
    }
    else
    {
      return CustomerHome();
    }
  }
}