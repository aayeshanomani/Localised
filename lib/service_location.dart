import 'dart:async';

import 'package:location/location.dart';

import 'model_userlocation.dart';

class LocationService
{
  UserLocation _currLocation;

  //stream
  StreamController<UserLocation> _locationController = StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService()
  {
    location.requestPermission().then((granted)
    {
      if(granted != null)
      {
        location.onLocationChanged.listen((locationData)
        {
          if(locationData != null)
          {
            _locationController.add(UserLocation(lat: locationData.latitude, long: locationData.longitude));
          }
        });
      }
    });
  }

  Location location = Location();
  Future<UserLocation> getLocation() async
  {
    try
    {
      var userLocation = await location.getLocation();
      _currLocation = UserLocation(lat: userLocation.latitude, long: userLocation.longitude);
    }
    catch(e)
    {
      print('could not get location: $e');
    }

    return _currLocation;
  }
}