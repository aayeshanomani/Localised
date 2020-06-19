import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container
      (
      child: Center
        (
        child: Text('Chat Conversation'),
      ),
    );
  }
}
