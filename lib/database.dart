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

class DatabaseMethods
{
  //chat
  createChatRoom(String chatRoomId, chatRoomMap)
  {
    Firestore.instance.collection('ChatRoom')
        .document(chatRoomId).setData(chatRoomMap).catchError((e)
    {
      print(e.toString());
      print("CHATTTTT ERRORRRRRRRR");
    });
  }

  getUserByEmail(String email) async
  {
    return await Firestore.instance.collection('locations')
        .where("email", isEqualTo: email)
        .getDocuments();
  }
}