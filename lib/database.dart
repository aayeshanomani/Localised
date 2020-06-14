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
    });
  }
}

class DatabaseMethods
{
  createChatRoom(String chatroomId, chatroomMap)
  {
    Firestore.instance.collection('chatroom')
    .document(chatroomId).setData(chatroomMap).catchError((e)
    {
      print(e.toString());
    });
  }
}