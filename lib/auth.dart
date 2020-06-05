import 'package:firebase_auth/firebase_auth.dart';
import 'package:localised/choice.dart';
import 'package:localised/database.dart';
import 'package:localised/model_userlocation.dart';
import 'package:localised/user.dart';

class Auth
{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser
  User _userFromFirebase(FirebaseUser user)
  {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebase(user));
    .map(_userFromFirebase);
  }

  //sign anonymously
  Future signInAnon() async
  {
    try
    {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  //sign in email and password
  Future SignInEmailPassword(String email, String password) async
  {
    try
    {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  //sign up email and password
  Future CustSignUpEmailPassword(String username, String email, String password, UserLocation userLocation) async
  {
    try
    {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create new document for the user with uid
      await Database(uid: user.uid).updateUserData(user.uid,username,"customer", userLocation.lat, userLocation.long);
      return _userFromFirebase(user);

    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  //merchant sign up
  Future MerchSignUpEmailPassword(String username, String email, String password, UserLocation userLocation) async
  {
    try
    {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create new document for the user with uid
      await Database(uid: user.uid).updateUserData(user.uid,username,"merchant", userLocation.lat, userLocation.long);
      return _userFromFirebase(user);

    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async
  {
    try
    {
      return await _auth.signOut();
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }
}