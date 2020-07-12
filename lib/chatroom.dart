import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'conversation.dart';
import 'database.dart';
import 'helper.dart';
import 'loading.dart';

class ChatRoom extends StatefulWidget {

  final String type;

  const ChatRoom({this.type});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream chatRooms;

  bool load = false;

  Widget chatList()
  {
    return StreamBuilder
      (
      stream: chatRooms,
      builder: (context, snapshot)
      {
        if(snapshot.data.documents.length == 0)
        {
          return Container
          (
            child: Center
            (
              child: Text
              (
                'It\'s all empty here'
              ),
            ),
          );
        }
        return snapshot.hasData ? ListView.builder
          (
          itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index)
            {
              return ChatTile(username: snapshot.data.documents[index].data['chatRoomId']
                  .toString()
                  .replaceAll("_", "")
                  .replaceAll(Constants.myName, ""),
              chatRoomId: snapshot.data.documents[index].data['chatRoomId'], 
              lastMessage: widget.type,);
              //: Constants.lastMessage.toString());
            }
        ) : 
        Container
        (
          child: Center
          (
            child: Text
            (
              'It\'s all empty here'
            ),
          ),
        );
      },
    );
  }

  final FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    databaseMethods.getChatRooms(Constants.myName).then((value)
    {
      setState(() {
        chatRooms = value;
      });
    });
    super.initState();
  }

  getUserInfo() async
  {
    Constants.myName = await HelperFunc.getUsername();
    print(Constants.myName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        title: Text
        (
          'Orders',
        )
      ),
      body: Container
        (
          child: chatList()
        ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String username;
  final String chatRoomId;
  final String lastMessage;

  const ChatTile({ this.username, this.chatRoomId, this.lastMessage});
  @override
  Widget build(BuildContext context) {
    bool chats = false;
    return GestureDetector
    (
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute
          (
          builder: (context) => ConversationScreen(chatRoomId: chatRoomId,)
        ));
      },
      child: Container
        (
          decoration: BoxDecoration
          (
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
          ),
        margin: EdgeInsets.all(10),
        //color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Row
        (
            children: <Widget>
            [
              StreamBuilder
              (
                stream: Firestore.instance.collection('locations').snapshots(),
                builder: (context, snapshot) 
                {
                  print(snapshot.data.documents.length);
                  if(snapshot.data.documents.length<1)
                  {
                    return Container
                    (
                      child: Center
                      (
                        child: Text
                        (
                          'It\'s all empty here'
                        ),
                      ),
                    );
                  }
                  for (int i = 0; i < snapshot.data.documents.length; i++)
                  {
                    if(snapshot.data.documents[i]['name']==username)
                    {
                      chats = true;
                      return Container
                      (
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration
                        (
                          color: Colors.red[900],
                          image: DecorationImage
                          (
                            image: NetworkImage(snapshot.data.documents[i]['photoUrl']),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(83)),
                          boxShadow: 
                          [
                            BoxShadow(blurRadius: 2, color: Colors.black)
                          ]
                        ),
                      );
                    }
                  } 
                }
              ),
              SizedBox(width: 8.0,),
              Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text
                    (
                      username, 
                      style: TextStyle
                      (
                        color: Colors.redAccent[100],
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text
                  (
                    (lastMessage == 'customer' ? 'Place order to ' : 'Order received from ')+username ,
                    style: TextStyle
                    (
                      color: Colors.redAccent[700],
                      fontSize: 11,
                    ),
                  )
                ],
              )
            ],
          ),
      ),
    );
  }
}
