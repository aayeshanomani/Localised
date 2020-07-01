import 'package:flutter/material.dart';
import 'package:localised/auth.dart';
import 'package:localised/helper.dart';
import 'package:localised/loading.dart';
import 'package:localised/newloading.dart';
import 'package:localised/onboarding.dart';
import 'package:localised/user.dart';
import 'package:localised/wrapper.dart';
import 'package:provider/provider.dart';

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
        home: OnboardingScreen(),
      ),
    );
  }
}