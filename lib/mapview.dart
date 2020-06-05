

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:localised/loading.dart';
import 'package:provider/provider.dart';
import 'package:latlong/latlong.dart';

import 'model_userlocation.dart';

class MapView extends StatefulWidget {
  
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  List<Marker> allMarkers = [];

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
                child: IconButton
                (
                  icon: Icon(Icons.location_on),
                  color: Colors.lightBlueAccent[100],
                  iconSize: 39.0,
                  onPressed: ()
                  {
                    print(snapshot.data.documents[i]['name']);
                  }
                ),
              )
            )
          );
        }
        return 
        FlutterMap
        (
          options: new MapOptions
          (
            minZoom: 10.0,
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

  