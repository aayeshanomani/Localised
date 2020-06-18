import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localised/customer_home.dart';
import 'package:localised/database.dart';
import 'package:localised/loading.dart';
import 'package:localised/service_search.dart';

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
    var capitalizedValue = value.toUpperCase();

    if(queryResultSet.length == 0 && value.length == 1)
    {
      SearchService().searchByName(value).then((QuerySnapshot docs)
      {
        for(int i = 0; i<docs.documents.length; i++)
        {
          queryResultSet.add(docs.documents[i].data);
          showLoad = 1;
        }
        showLoad = 0;
      });
    }
    else
    {
      tempSearchStore = [];
      queryResultSet.forEach((element) 
      {
        if(element['name'].startsWith(value))
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
    return ListView
    (
      children: <Widget>
      [
        Padding
        (
          padding: const EdgeInsets.all(10.0),
          child: TextField
          (
            style: TextStyle(color: Colors.blueAccent[100]),
            onChanged: (value) {
              initiateSearch(value);
            },
            decoration: InputDecoration
            (
              prefixIcon: IconButton
              (
                color: Colors.blue[400],
                icon: Icon(Icons.arrow_back, color: Colors.blue[500],), 
                iconSize: 20.0,
                onPressed: ()
                {
                  Navigator.of(context).pop();
                }
              ),
              contentPadding: EdgeInsets.all(25.0),
              hintText: 'Search Shop By Name',
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
            return resultCard(e);
          }).toList()
        )
      ],
    );
  }
}

Widget resultCard(e)
{
  return Card
  (
    shape: RoundedRectangleBorder
    (
      borderRadius: BorderRadius.circular(30.0),
    ),
    color: Colors.indigo[100],
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
                  print("message");
                },
                child: Container
                (
                  decoration: BoxDecoration
                  (
                    color: Colors.indigo[200],
                    borderRadius: BorderRadius.circular(29.0)
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Text
                  (
                    'Message',
                    style: TextStyle(color: Colors.indigo[300]),
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