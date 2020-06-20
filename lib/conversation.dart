import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localised/constants.dart';
import 'package:localised/database.dart';
import 'package:localised/helper.dart';

class ConversationScreen extends StatefulWidget {
  String chatRoomId;

  ConversationScreen({
    this.chatRoomId
});
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  Stream<QuerySnapshot> chatMessagesStream;
  TextEditingController textEditingController = new TextEditingController();

  DatabaseMethods databaseMethods = new DatabaseMethods();
  Future<String> me = HelperFunc.getUsername();
  Widget Messages()
  {
    return StreamBuilder
      (
      stream: chatMessagesStream,
      builder: (context, snapshot)
      {
        return snapshot.hasData?ListView.builder
          (
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index)
          {
            return MessageTile(message: snapshot.data.documents[index].data["message"],
                sendByMe: Constants.myName == snapshot.data.documents[index].data["sendBy"]);
          },
        ):Container();
      },
    );
  }

  sendMessage(String message) async
  {
    if (message != null) {
      Map<String, dynamic> messageMap = {
        "message": message,
        "sendBy": await HelperFunc.getUsername(),
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addMessages(widget.chatRoomId, messageMap);
      textEditingController.text = "";
    }
  }

  readyChat()
  {
    print("in ready chat");
    databaseMethods.getMessages(widget.chatRoomId).then((val)
    {
      if(val != null) {
        setState(() {
          chatMessagesStream = val;
        });
      }
      print("got val");
    });
    me = HelperFunc.getUsername();
  }

  @override
  void initState() {
    // TODO: implement initState
    readyChat();
    super.initState();
  }

  String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar: AppBar
        (
        backgroundColor: Colors.blueGrey[100],
        elevation: 0.0,
        title: Text
          (
          widget.chatRoomId.replaceAll("_", "")
              .replaceAll(Constants.myName, ""),
        ),
      ),
      body: Container
        (
        color: Colors.grey[350],
        child: Stack
          (
          children:
          [
            Center(
              child: Container
                (
                padding: EdgeInsets.only
                  (
                  bottom: 100
                ),
                  child: Messages()
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              //color: Colors.grey[100],
              alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(10),
                child: TextField
                  (
                  controller: textEditingController,
                  style: TextStyle(color: Colors.blueAccent[100]),
                  onChanged: (value) {
                    //initiateSearch(value);
                    message = value;
                  },
                  decoration: InputDecoration
                    (
                    suffixIcon: IconButton
                      (
                        color: Colors.blue[400],
                        icon: Icon(Icons.send, color: Colors.blue[500],),
                        iconSize: 30.0,
                        onPressed: () {
                          sendMessage(message);
                        }
                    ),
                    contentPadding: EdgeInsets.all(25.0),
                    hintText: 'Type your message',
                    hintStyle: TextStyle(color: Colors.blue[700]),
                    enabledBorder: OutlineInputBorder
                      (
                      borderSide: BorderSide
                        (
                        color: Colors.blue[700],
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    ),
                    focusedBorder: OutlineInputBorder
                      (
                      borderSide: BorderSide
                        (
                        color: Colors.blue[800],
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


class MessageTile extends StatelessWidget {

  final String message;
  final bool sendByMe;

  const MessageTile({this.message, this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: MediaQuery.of(context).size.width,
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container
        (
        margin: sendByMe
            ? EdgeInsets.only(left: 70)
            : EdgeInsets.only(right: 50),
        padding: EdgeInsets.all(11),
        decoration: BoxDecoration
          (
          gradient: LinearGradient
            (
            colors: sendByMe ?
            [
              Colors.blueGrey[900],
              Colors.blueGrey[800]
            ] :
                [
                  Colors.brown[50],
                  Colors.brown[100]
                ]
          ),
          borderRadius: sendByMe ? BorderRadius.only
            (
            topLeft: Radius.circular(26.0),
                topRight: Radius.circular(37),
              bottomLeft: Radius.circular(45)
          ):
              BorderRadius.only
                (
                topRight: Radius.circular(38.0),
                topLeft: Radius.circular(37),
                bottomRight: Radius.circular(82)
              )
        ),
        child: Text
          (
          message,
          style: TextStyle(color: sendByMe ? Colors.blueGrey[200] : Colors.black),
        ),
      ),
    );
  }
}
