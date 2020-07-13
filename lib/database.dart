import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

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
    String subsDate,
    String expDate,
    bool payment,
    double latitude,
    double longitude
  ) async
  {
    return await location.document(uid).setData({
      'id': id,
      'searchKey': searchKey,
      'name': name,
      'type': type,
      'subsDate': subsDate,
      'expDate': expDate,
      'payment': payment,
      'latitude': latitude,
      'longitude': longitude,
      'email': email,
      'photoUrl': 'https://wallpapercave.com/wp/wp5174771.jpg'
    });
  }
}

class DatabaseMethods
{
  getPaymentStatus(String username) async
  {
    return await Firestore.instance.collection('locations')
    .where("name", isEqualTo: username)
    .snapshots();
  }
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

  updateChatRoom(String chatRoomId, chatRoomMap)
  {
    Firestore.instance.collection('ChatRoom')
      .document(chatRoomId)
      .updateData(chatRoomMap)
      .catchError((e)
      {
        print(e.toString());
      });
  }

  getUserByEmail(String email) async
  {
    return await Firestore.instance.collection('locations')
        .where("email", isEqualTo: email)
        .getDocuments();
  }

  Future<bool> usernameCheck(String username) async {
    final result = await Firestore.instance
        .collection('locations')
        .where('name', isEqualTo: username)
        .getDocuments();
    return result.documents.isEmpty;
  }
  
  addMessages(String chatRoomId, messageMap)
  {
    print(chatRoomId);
    Firestore.instance.collection('ChatRoom')
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e)
    {
      print(e.toString());
    });
  }

  addToken(token)
  {
    print(token);
    Firestore.instance.collection('tokens')
      .add(token)
      .catchError((e)
      {
        print(e.toString());
      });
  }

  getChatRooms(String username) async
  {
    return await Firestore.instance.collection("ChatRoom")
    .where("users", arrayContains: username)
    .snapshots();
  }

  getMessages(String chatRoomId) async
  {
    print(chatRoomId+" get messages");
    try{
      return Firestore.instance.collection('ChatRoom')
          .document(chatRoomId)
          .collection("chats")
          .orderBy("time", descending: false)
          .snapshots();
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  addCard(token)
  {
    FirebaseAuth.instance.currentUser()
    .then((value) => 
    {
      Firestore.instance.collection('cards')
      .document(value.uid)
      .collection('tokens')
    });
  }

  deleteDatabase(String chatRoomId, String uid)
  {
    Firestore.instance.collection("ChatRoom")
    .document(chatRoomId)
    .delete();
  }
}