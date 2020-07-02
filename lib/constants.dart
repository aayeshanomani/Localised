import 'package:flutter/material.dart';
import 'package:localised/database.dart';
import 'package:localised/helper.dart';
import 'package:localised/user.dart';
import 'package:provider/provider.dart';

const textInputDecoration = InputDecoration
(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder
  (
    borderSide: BorderSide
    (
      color: Colors.lightBlue,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(40.0)),
  ),
  focusedBorder: OutlineInputBorder
  (
    borderSide: BorderSide
    (
      color: Colors.black,
      width: 2.0,
    ),
  ),
);

class Constants
{
  static String myName;
  static String lastMessage;
}