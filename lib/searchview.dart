import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'chatroom.dart';
import 'constants.dart';
import 'customer_home.dart';
import 'database.dart';
import 'helper.dart';
import 'loading.dart';
import 'service_search.dart';

import 'conversation.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  var tempSearchStore = [];
  var queryResultSet = [];
  var showLoad = 0;

  initiateSearch(value)
  {
    if(value.length == 0)
    {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    var capitalizedValue = value[0].toUpperCase()+value.substring(1,value.length);
    print(capitalizedValue);

    if(queryResultSet.length == 0 && value.length == 1)
    {
      print(queryResultSet);
      SearchService().searchByName(capitalizedValue).then((QuerySnapshot docs)
      {
        for(int i = 0; i<docs.documents.length; i++)
        {
          queryResultSet.add(docs.documents[i].data);
          showLoad = 1;
          print(queryResultSet);
        }
        showLoad = 0;
      });
    }
    else
    {
      tempSearchStore = [];
      queryResultSet.forEach((element) 
      {
        //print(tempSearchStore);
        if(element['name'].startsWith(capitalizedValue))
        {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.red[900]),
    );

    return Scaffold(
      appBar: AppBar
      (
        title: Text('Search',
        style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        elevation: 6.0,
      ),
      body: Container(
        child: ListView
        (
          children: <Widget>
          [
            Padding
            (
              padding: const EdgeInsets.all(10.0),
              child: TextField
              (
                style: TextStyle(color: Colors.redAccent),
                onChanged: (value) {
                  initiateSearch(value);
                },
                decoration: InputDecoration
                (
                  prefixIcon: IconButton
                  (
                    color: Colors.redAccent,
                    icon: Icon(Icons.arrow_back, color: Colors.redAccent,), 
                    iconSize: 20.0,
                    onPressed: ()
                    {
                      Navigator.of(context).pop();
                    }
                  ),
                  contentPadding: EdgeInsets.all(25.0),
                  hintText: 'Search Shop By Name',
                  hintStyle: TextStyle(color: Colors.redAccent),
                  enabledBorder: OutlineInputBorder
                  (
                    borderSide: BorderSide
                    (
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  ),
                  focusedBorder: OutlineInputBorder
                  (
                    borderSide: BorderSide
                    (
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.0,),
            GridView.count
            (
              crossAxisCount: 2,
              padding: EdgeInsets.only(left: 10.0, right:10.0),
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              children: tempSearchStore.map((e) 
              {
                return resultCard(context, e);
              }).toList()
            )
          ],
        ),
      ),
    );
  }
}

Widget resultCard(BuildContext context, e)
{
  return Card
  (
    shape: RoundedRectangleBorder
    (
      borderRadius: BorderRadius.circular(30.0),
    ),
    color: Colors.red[100],
    elevation: 3.0,
    child: Container
    (
      child: Column
      (
        children: <Widget>
        [
          Padding(padding: EdgeInsets.all(20.0)),
          SizedBox(height: 20.0),
          Center(
            child: Text
            (
              e['name'].toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle
              (
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(height: 40.0),
          //Spacer(),
          Row(
            children: <Widget>[
              SizedBox(width:80.0),
              GestureDetector
              (
                onTap: ()
                {
                  print("message "+e['name']);
                  startChat(context, e['name']);
                },
                child: Container
                (
                  decoration: BoxDecoration
                  (
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(29.0),
                    boxShadow: 
                    [
                      BoxShadow(blurRadius: 2, color: Colors.black)
                    ]
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Text
                  (
                    'Message',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

getChatRoomId(String a, String b)
{
  print(a);
  print(b);
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0))
    {
      return "$b\_$a";
    }
  else
    {
      return "$a\_$b";
    }
}

startChat(BuildContext context, String username) async
{

  DatabaseMethods databaseMethods = new DatabaseMethods();

  String chatRoomId = getChatRoomId(username, await HelperFunc.getUsername());
  List<String> users = [username, await HelperFunc.getUsername()];
  Map<String, dynamic> chatRoomMap =
  {
    "users": users,
    "chatRoomId": chatRoomId
  };

  print(chatRoomMap);
  databaseMethods.createChatRoom(chatRoomId, chatRoomMap);

  Navigator.push(context, MaterialPageRoute(
      builder: (context) => ConversationScreen(chatRoomId: chatRoomId,)
  ));
}