import 'package:flutter/material.dart';
import 'auth.dart';
import 'conversation.dart';
import 'helper.dart';
import 'loading.dart';
import 'newloading.dart';
import 'onboarding.dart';
import 'splash.dart';
import 'user.dart';
import 'wrapper.dart';
import 'package:provider/provider.dart';

import 'payment.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Auth().user,
      child: MaterialApp
      (
        debugShowCheckedModeBanner: false,
        home: PaymentScreen(),
      ),
    );
  }
}