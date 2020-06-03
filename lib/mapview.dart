import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:latlong/latlong.dart';

import 'model_userlocation.dart';

class Mapview extends StatelessWidget {

  List<Marker> allMarkers = [];

  @override
  Widget build(BuildContext context) {

    var userLocation = Provider.of<UserLocation>(context);


    setMarkers()
    {
      allMarkers.add
      (
        new Marker
        (
          width: 74.0,
          height: 95.0,
          point: new LatLng(userLocation.lat,userLocation.long),
          builder: (context) => new Container
          (
            child: IconButton
            (
              icon: Icon(Icons.location_on),
              color: Colors.lightBlueAccent[100],
              iconSize: 39.0,
              onPressed: ()
              {
                print('clicked');
              }
            ),
          )
        )
      );
      return allMarkers;
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
            markers: setMarkers()
          )
        ],
      );
  }
}