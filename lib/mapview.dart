import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'loading.dart';
import 'searchview.dart';
import 'package:provider/provider.dart';
import 'package:latlong/latlong.dart';

import 'constants.dart';
import 'conversation.dart';
import 'database.dart';
import 'model_userlocation.dart';

class MapView extends StatefulWidget {
  
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  List<Marker> allMarkers = [];
  List<String> receivers = [];

  Widget _child = Center
  (
    child: Text
    (
      'Loading...'
    ),
  );

  Widget loadMap()
  {

    var userLocation = Provider.of<UserLocation>(context);
    return StreamBuilder
    (
      stream: Firestore.instance.collection('locations').snapshots(),
      builder: (context, snapshot)
      {
        if(!snapshot.hasData) return Loading();

        for(int i = 0; i<snapshot.data.documents.length; i++)
        {
          Dialog errorDialog = Dialog
          (
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
            child: Container
            (
              //
              decoration: BoxDecoration
              (
                gradient: new LinearGradient
                (
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                      Colors.redAccent[100]
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 0.5 ,1.0],
                    tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(38.0)
              ),
              height: 300.0,
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.all(15.0),
                    child: Container
                      (
                        width: 100,
                        height: 100,
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
                            BoxShadow(blurRadius: 16, color: Colors.black)
                          ]
                        ),
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text
                    (
                      'Order from '+snapshot.data.documents[i]['name'], 
                      style: TextStyle
                      (
                        color: Colors.red,
                        fontSize: 20.0
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 50.0)),
                  Row
                  (
                    children: <Widget>
                    [
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: MaterialButton
                        (
                          highlightColor: Colors.transparent,
                          splashColor: Colors.deepOrangeAccent,
                          color: Colors.redAccent[100],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                          onPressed: () 
                          {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: "Lato"),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: MaterialButton
                        (
                          highlightColor: Colors.transparent,
                          splashColor: Colors.deepOrangeAccent,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                          onPressed: () 
                          {
                            startChat(context, snapshot.data.documents[i]['name']);
                          },
                          child: Text(
                            "Message",
                            style: TextStyle(
                                color: Colors.redAccent[100],
                                fontSize: 18.0,
                                fontFamily: "Lato"),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
          if(snapshot.data.documents[i]['type'] == 'merchant')
          {
            allMarkers.add
            (
              new Marker
              (
                width: 74.0,
                height: 95.0,
                point: new LatLng
                (
                  snapshot.data.documents[i]['latitude'],
                  snapshot.data.documents[i]['longitude'],
                ),
                builder: (context) => new Container
                (
                  child: GestureDetector
                  (
                    child: IconButton
                    (
                      icon: Stack
                      (
                        children: <Widget>
                        [
                          Positioned(
                            left: 2.0,
                            top: 2.0,
                            child: Icon(Icons.home, color: Colors.black54),
                          ),
                          Icon(Icons.home)
                        ],
                      ),
                      color: Colors.redAccent,
                      iconSize: 35.0,
                      onPressed: ()
                      {
                        print(snapshot.data.documents[i]['name']);
                        //showDialog(context: snapshot.data.documents[i]['name']);
                        //showToast(snapshot.data.documents[i]['name']);
                        final snackBar = SnackBar(
                          content: Text("Shop: "+snapshot.data.documents[i]['name']),
                          action: SnackBarAction(
                            label: 'Message',
                            onPressed: () {
                              print('message');
                              startChat(context, snapshot.data.documents[i]['name']);
                            },
                          ),
                        );
                        //Scaffold.of(context).showSnackBar(snackBar);
                        showDialog(context: context, builder: (BuildContext context) => errorDialog);
                      },
                    ),
                    /*onDoubleTap: ()
                    {
                      if(!receivers.contains(snapshot.data.documents[i]['name']))
                        receivers.add(snapshot.data.documents[i]['name']);
                      print(receivers);
                      //showToast(snapshot.data.documents[i]['name']);
                    },*/
                  ),
                ),
              )
            );
          }
        }
        return 
        FlutterMap
        (
          options: new MapOptions
          (
            minZoom: 16.0,
            center: new LatLng(userLocation.lat, userLocation.long),
          ),
          layers: 
          [
            new TileLayerOptions
            (
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: 
              [
                'a','b','c'
              ]

            ),
            new MarkerLayerOptions
            (
              markers: allMarkers
            )
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    setMarkers()
    {
      return allMarkers;
    }

    return loadMap();
    
  }
}