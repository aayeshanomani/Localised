import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localised/loading.dart';
import 'package:localised/searchview.dart';
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
                        Scaffold.of(context).showSnackBar(snackBar);
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