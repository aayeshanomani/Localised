import 'package:flutter/material.dart';
import 'package:localised/auth.dart';

import 'package:geolocator/geolocator.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class 
CustomerHome extends StatelessWidget {

  final Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      backgroundColor: Colors.indigoAccent[400],
      appBar: AppBar
      (
        title: Text('Home',
        style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.lightBlue[50],
        elevation: 0.0,
        actions: <Widget>
        [
          FlatButton.icon
          (
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async
            {
              await _auth.signOut();
            },
          )
        ],
      ),

      body: new FlutterMap
      (
        options: new MapOptions
        (
          minZoom: 10.0,
          center: new LatLng(40.71,-73.93),
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
            markers:
            [
              new Marker
              (
                width: 74.0,
                height: 95.0,
                point: new LatLng(40.71,-73.93),
                builder: (context) => new Container
                (
                  child: IconButton
                  (
                    icon: Icon(Icons.location_searching),
                    color: Colors.lightBlueAccent[100],
                    iconSize: 39.0,
                    onPressed: ()
                    {
                      print('clicked');
                    }
                  ),
                )
              )
            ] 
          )
        ],
      ),
    );
  }
}