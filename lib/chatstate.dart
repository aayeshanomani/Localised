import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localised/loading.dart';
import 'package:provider/provider.dart';

import 'user.dart';

class ChatView extends StatefulWidget {

  FirebaseUser user;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    TextEditingController messageController = TextEditingController();
    ScrollController scrollController = ScrollController();

    final user = Provider.of<User>(context);
    return SafeArea
    (
      child: Column
      (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>
        [
          Expanded
          (
            child: StreamBuilder<QuerySnapshot>
            (
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshot)
              {
                if(!snapshot.hasData)
                {
                  return Loading();
                }

                return ListView();
              },
            )
          )
        ],
      ),
    );
  }
}