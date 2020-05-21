import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:localised/loading.dart';
import 'package:localised/model_userlocation.dart';
import 'package:provider/provider.dart';

import 'auth.dart';

class 
CustomerHome extends StatelessWidget {

  final Auth _auth = Auth();
  @override
  Widget build(BuildContext context) 
  {

    var userLocation = Provider.of<UserLocation>(context);
    return userLocation == null ? Loading() : Scaffold
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
            markers:
            [
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
            ] 
          )
        ],
      ),
    );
  }
}