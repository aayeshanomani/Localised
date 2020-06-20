import 'package:flutter/material.dart';
import 'package:localised/constants.dart';
import 'package:localised/conversation.dart';
import 'package:localised/database.dart';
import 'package:localised/helper.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream chatRooms;

  Widget chatList()
  {
    return StreamBuilder
      (
      stream: chatRooms,
      builder: (context, snapshot)
      {
        return snapshot.hasData ? ListView.builder
          (
          itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index)
            {
              return ChatTile(username: snapshot.data.documents[index].data['chatRoomId']
                  .toString()
                  .replaceAll("_", "")
                  .replaceAll(Constants.myName, ""),
              chatRoomId: snapshot.data.documents[index].data['chatRoomId'],);
            }
        ) : Container();
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
    return chatList();
  }
}

class ChatTile extends StatelessWidget {
  final String username;
  final String chatRoomId;

  const ChatTile({ this.username, this.chatRoomId});
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
        margin: EdgeInsets.all(10),
        color: Colors.brown[600],
        padding: EdgeInsets.all(10),
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
                color: Colors.brown[200],
                borderRadius: BorderRadius.circular(78)
              ),
              child: Center(
                child: Text
                  (
                    username.substring(0,1).toUpperCase()
                ),
              ),
            ),
            SizedBox(width: 8.0,),
            Text(username, style: TextStyle(color: Colors.brown[300]),)
          ],
        ),
      ),
    );
  }
}
