import 'package:cloud_firestore/cloud_firestore.dart';

class Database
{
  //references
  final CollectionReference location = Firestore.instance.collection('locations');
  
}