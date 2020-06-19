import 'package:flutter/material.dart';
import 'package:localised/constants.dart';
import 'package:localised/helper.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getUserInfo() async
  {
    Constants.myName = await HelperFunc.getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
