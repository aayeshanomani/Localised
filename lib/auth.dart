
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'database.dart';
import 'model_userlocation.dart';
import 'user.dart';

import 'helper.dart';
//import 'package:google_sign_in/google_sign_in.dart';

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

  QuerySnapshot snapshot;

  //sign in email and password
  Future SignInEmailPassword(String email, String password) async
  {
    try
    {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      HelperFunc.saveUserloggedIn(true);
      HelperFunc.saveUserEmail(email);
      DatabaseMethods().getUserByEmail(email)
          .then((val){
        snapshot = val;
        HelperFunc.saveUsername(snapshot.documents[0].data['name']);
        FirebaseMessaging _messaging = FirebaseMessaging();
        _messaging.getToken().then((value)
        {
          print('TOKEN   '+value);
          Map<String, dynamic> token = 
          {
            "token": value,
            "username": snapshot.documents[0].data['name']
          };
          DatabaseMethods databaseMethods = DatabaseMethods();
          databaseMethods.addToken(token);
        });
      });
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

      HelperFunc.saveUserloggedIn(true);
      HelperFunc.saveUsername(username);
      HelperFunc.saveUserEmail(email);
      //create new document for the user with uid
      await Database(uid: user.uid).updateUserData
      (
        user.uid,
        username[0],
        username,
        email,
        "customer",
        'na',
        'na',
        true,
        userLocation.lat,
        userLocation.long
      );
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

      HelperFunc.saveUserloggedIn(true);
      HelperFunc.saveUsername(username);
      HelperFunc.saveUserEmail(email);
      //create new document for the user with uid
      await Database(uid: user.uid).updateUserData
      (
        user.uid,
        username[0],
        username,
        email,
        "merchant",
        (DateTime.now().millisecondsSinceEpoch).toString(),
        (DateTime.now().millisecondsSinceEpoch + 90*24*60*60*1000).toString(),
        false,
        userLocation.lat, 
        userLocation.long
      );
      return _userFromFirebase(user);

    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email)
  async {
    try
    {
      return await _auth.sendPasswordResetEmail(email: email);
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  /*Future<FirebaseUser> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = new GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount =
    await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = await _auth.signInWithCredential(credential);
    FirebaseUser userDetails = result.user;

    if (result == null) {
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Chat()));
    }
  }*/

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