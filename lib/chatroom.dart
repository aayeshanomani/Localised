import 'package:flutter/material.dart';
import 'package:localised/constants.dart';
import 'package:localised/conversation.dart';
import 'package:localised/database.dart';
import 'package:localised/helper.dart';
import 'package:localised/loading.dart';

class ChatRoom extends StatefulWidget {
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
              chatRoomId: snapshot.data.documents[index].data['chatRoomId']);
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
        backgroundColor: Colors.red[200],
        elevation: 0.0,
        title: Text
        (
          'Orders',
        )
      ),
      body: Container
      (
        child: chatList()
      )
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
    return GestureDetector(
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
            Container
              (
              height: 40,
              width: 40,
              decoration: BoxDecoration
                (
                color: Colors.pink[200],
                borderRadius: BorderRadius.circular(78)
              ),
              child: Center(
                child: Text
                  (
                    username.substring(0,1).toUpperCase(),
                    style: TextStyle
                    (
                      color: Colors.white,
                      fontSize: 18
                    ),
                ),
              ),
            ),
            SizedBox(width: 8.0,),
            Column(
              children: <Widget>[
                Text
                (
                  username, 
                  style: TextStyle
                  (
                    color: Colors.red[300],
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 5),
                Text
                (
                  'Order from '+username,
                  style: TextStyle
                  (
                    color: Colors.pink[900],
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
