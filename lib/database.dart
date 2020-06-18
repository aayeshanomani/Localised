import 'package:cloud_firestore/cloud_firestore.dart';

class Database
{

  final String uid;

  Database({
    this.uid
  });

  //references
  final CollectionReference location = Firestore.instance.collection('locations');

  Future updateUserData
  (
    String id,
    String searchKey,
    String name,
    String email,
    String type,
    double latitude,
    double longitude
  ) async
  {
    return await location.document(uid).setData({
      'id': id,
      'searchKey': searchKey,
      'name': name,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'email': email
    });
  }
}

class DatabaseChat
{

  final String name;

  DatabaseChat({
    this.name
  });

  //references
  final CollectionReference location = Firestore.instance.collection('chatroom');

  Future updateUserData
  (
    String name,
    String email,
    List receiverName
  ) async
  {
    return await location.document(name).setData({
      'name': name,
      'email': email,
      'receiverName': receiverName
    });
  }
}