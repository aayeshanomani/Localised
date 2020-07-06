//import 'dart:html';

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localised/auth.dart';
import 'package:localised/database.dart';
import 'package:localised/helper.dart';
import 'package:localised/merchant_home.dart';
import 'package:localised/user.dart';
import 'package:provider/provider.dart';

import 'loading.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Auth _auth = Auth();
  File sampleImage;
  String username = "";
  String url = 'https://wallpapercave.com/wp/wp5174771.jpg';
  String newurl;
  bool editScreen = false;
  bool loading = false;
  int k = 1;
  final CollectionReference location = Firestore.instance.collection('locations');

  Future getImage() async
  {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 20);
    setState(() {
      sampleImage = tempImage;
    });
    uploadImageTest();
    showInSnackBar('If Current Image is not loaded press save button again to reload');
    setState(() {
      editScreen = false;
      editScreen = true;
    });
    uploadImageTest();
  }

  uploadImageTest() async
  {
    loading = true;
    print('taking');
    final user = Provider.of<User>(context);
    print('user');
    final StorageReference storageReference = FirebaseStorage.instance.ref().child('test/${user.uid.toString()}.jpg');
    print('uploaded');
    StorageUploadTask task = storageReference.putFile(sampleImage);
    while(task==null)
    {
      task = storageReference.putFile(sampleImage);
    }
    print('task done');
    var pic;
    try{
      pic = await storageReference.getDownloadURL() as String;
      pic = await storageReference.getDownloadURL() as String;
    }
    catch(e)
    {
      print(e.toString());
    }
    
    print('url loaded');
    setState(() {
      url = pic;
      newurl = url;
    });
    print(newurl);
    loading = false;
  }

  uploadImage() async
  {
    //loading = true;
    final user = Provider.of<User>(context);
    final StorageReference storageReference = FirebaseStorage.instance.ref().child('photos/${user.uid}.jpg');
    StorageUploadTask task = storageReference.putFile(sampleImage);
    print('upload again');
    try{
      url = await storageReference.getDownloadURL() as String;
    }catch(e)
    {
      print('PIC URL DOWNLOAD ERROR'+e.toString());
    }
    
    print(url);
    updateDP(url);
    /*task.future.then((value)
    {
      updateDP(value.downloadUrl.toString());
      url = value.downloadUrl.toString();
    }).catchError((e){
      print(e.toString());
    });*/
  }

  Future updateDP(picurl) async
  {
    final user = Provider.of<User>(context);
    location.document(user.uid).updateData
    ({
      'photoUrl': picurl
    });
  }

  readyProfile() async
  {
    setState(() async{
      //username = await HelperFunc.getUsername();
      loading = false;
    });
  }

  @override
  void initState() {
    readyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return editScreen ?
    Scaffold
    (
      key: _scaffoldKey,
      appBar: AppBar
      (
        title: Text('Edit Profile',
        style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        elevation: 28.0,
        actions: <Widget>
        [
          FlatButton.icon
          (
            icon: Icon
            (
              FontAwesomeIcons.arrowCircleRight,
              color: Colors.white,
              size: 25.0,
            ),
            label: Text
            (
              'wxit',
              style: TextStyle
              (
                color: Colors.white,
                fontSize: 0.0
              ),
            ),
            onPressed: ()
            {
              setState(() {
                editScreen = false;
                loading = false;
              });
            },
          )
        ],
      ),
      body: Stack
      (
        children: <Widget>
        [
          ClipPath
          (
            child: Container
            (
              color: Colors.red[800].withOpacity(0.8),
            ),
            clipper: getClipper(),
          ),
          Positioned
          (
            width: 350,
            top: MediaQuery.of(context).size.height/5.8,
            left: MediaQuery.of(context).size.width/16,
            child: StreamBuilder
            (
              stream: Firestore.instance.collection('locations').where('id', isEqualTo: user.uid).snapshots(),
              builder: (context, snapshot)
              {
                return SingleChildScrollView
                (
                  child: Column
                  (
                    children: <Widget>
                    [
                      SizedBox(height: 22.0),
                      loading? SpinKitCubeGrid(color: Colors.deepOrange[100],) :Container
                      (
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration
                        (
                          color: Colors.red[900],
                          image: DecorationImage
                          (
                            image: NetworkImage(snapshot.data.documents[0]['photoUrl']),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(83)),
                          boxShadow: 
                          [
                            BoxShadow(blurRadius: 16, color: Colors.black)
                          ]
                        ),
                      ),
                      SizedBox(height: 22.0),
                      GestureDetector
                      (
                        onTap: ()
                        {
                          print('dp');
                          getImage();
                        },
                        child: Text 
                        (
                          loading? '' : 'Change Profile Photo',
                          style: TextStyle
                          (
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Lato',
                            color: Colors.black
                          ),
                        ),
                      ),
                      SizedBox(height: 58),
                      TextField 
                      (
                        onChanged: (value) 
                        {
                          setState(() {
                            username = value;
                          });
                          print(username);
                        },
                        decoration: InputDecoration
                        (
                          hintText: snapshot.data.documents[0]['name'],
                          labelText: 'Username',
                          labelStyle: TextStyle
                          (
                            color: Colors.redAccent[700],
                            fontSize: 10.0
                          )
                        ),
                        //
                        style: TextStyle
                        (
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                          color: Colors.black
                        ),
                      ),
                      SizedBox(height: 22.0),
                      SizedBox(height: 28),
                    ],
                  ),
                );
              }
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton
      (
        onPressed: () async
        {
          DatabaseMethods databaseMethods = new DatabaseMethods();
          final valid = await databaseMethods.usernameCheck(username);
          if(username != null && username != "")
          {
            if(username.length<4)
              showInSnackBar('Username too short');
            else if (!valid) 
              showInSnackBar('Username Already Taken');
            else
            {
              location.document(user.uid).updateData
              ({
                'name': username,
                'searchKey': username[0]
              });
              setState(() {
                editScreen = false;
                username = "";
              });
            }
          }
          if(sampleImage!=null)
          {
            uploadImage();
            showInSnackBar('If Current Image is not loaded press save button again to reload');
          }
         print(username);
        },
        tooltip: "Get Image",
        child: Icon
        (
          FontAwesomeIcons.save
        ),
        backgroundColor: Colors.red[700],
      ),
    ) :
    Scaffold(
      /*appBar: AppBar
      (
        title: Text('Profile',
        style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        elevation: 28.0,
        actions: <Widget>
        [
          FlatButton.icon
          (
            icon: Icon
            (
              FontAwesomeIcons.lockOpen,
              color: Colors.white,
            ),
            label: Text
            (
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async
            {
              await _auth.signOut();
            },
          )
        ],
      ),*/
      body:
        /*child: Container
        (
          height: 1000,
          width: 1000,
          decoration: BoxDecoration
          (
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.5, 1.0],
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Colors.red[400]
              ],
            ),
          ),
          child: sampleImage == null ? Column(
            children: <Widget>[
              SizedBox(height: 28,),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.redAccent,
                child: Icon
                (
                  FontAwesomeIcons.shoePrints,
                  size: 50,
                ),
              ),
              SizedBox(height: 28,),
              Text('Upload Image')
            ],
          ): enableUpload()
        ),*/
      Stack
      (
        children: <Widget>
        [
          ClipPath
          (
            child: Container
            (
              color: Colors.red[800].withOpacity(0.8),
            ),
            clipper: getClipper(),
          ),
          Positioned
          (
            width: 350,
            top: MediaQuery.of(context).size.height/4.4,
            left: MediaQuery.of(context).size.width/16,
            child: StreamBuilder
            (
              stream: Firestore.instance.collection('locations').where('id', isEqualTo: user.uid).snapshots(),
              builder: (context, snapshot)
              {
                return Column
                (
                  children: <Widget>
                  [
                    Container
                    (
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration
                      (
                        color: Colors.red[900],
                        image: DecorationImage
                        (
                          image: NetworkImage((snapshot.data.documents[0]['photoUrl']!=null
                                && snapshot.data.documents[0]['photoUrl']!="")? 
                                snapshot.data.documents[0]['photoUrl'] : url),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(83)),
                        boxShadow: 
                        [
                          BoxShadow(blurRadius: 16, color: Colors.black)
                        ]
                      ),
                    ),
                    SizedBox(height: 90),
                    Text 
                    (
                      snapshot.data.documents[0]['name'],
                      style: TextStyle
                      (
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                        color: Colors.black
                      ),
                    ),
                    SizedBox(height: 22.0),
                    Text 
                    (
                      snapshot.data.documents[0]['email'],
                      style: TextStyle
                      (
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Lato',
                        color: Colors.black
                      ),
                    ),
                    SizedBox(height: 28),
                    Container
                    (
                      height: 30,
                      width: 95,
                      child: Material
                      (
                        borderRadius: BorderRadius.circular(28),
                        shadowColor: Colors.redAccent[100],
                        color: Colors.redAccent,
                        elevation: 7.0,
                        child: GestureDetector
                        (
                          onTap: ()
                          {
                            setState(() {
                              editScreen = true;
                            });
                          },
                          child: Center
                          (
                            child: Text
                            (
                              'Edit Profile',
                              style: TextStyle
                              (
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 28),
                    Container
                    (
                      height: 30,
                      width: 95,
                      child: Material
                      (
                        borderRadius: BorderRadius.circular(28),
                        shadowColor: Colors.redAccent[400],
                        color: Colors.redAccent[700],
                        elevation: 7.0,
                        child: GestureDetector
                        (
                          onTap: () async
                          {
                            await _auth.signOut();
                          },
                          child: Center
                          (
                            child: Text
                            (
                              'Logout',
                              style: TextStyle
                              (
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
            )
          ),
        ],
      ),
      /*floatingActionButton: FloatingActionButton
      (
        onPressed: ()
        {
          getImage();
        },
        tooltip: "Get Image",
        child: Icon
        (
          FontAwesomeIcons.palette,
        ),
        backgroundColor: Colors.red[700],
      ),*/
    );
  }
  
  Widget enableUpload()
  {
    return Container
    (
      child: Column
      (
        children: <Widget>
        [
          Image.file(sampleImage, height: 300, width: 300),
          RaisedButton
          (
            elevation: 28,
            color: Colors.red[600],
            shape: new RoundedRectangleBorder
            (
              borderRadius: new BorderRadius.circular(7.0),
            ),
            child: Text
            (
              'Upload',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: ()
            {
              final StorageReference storageReference = FirebaseStorage.instance.ref().child('username/propic.jpg');
              final StorageUploadTask task = storageReference.putFile(sampleImage);
            },
          )
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontFamily: "Lato"),
      ),
      backgroundColor: Colors.deepOrange[50],
      duration: Duration(seconds: 3),
    ));
  }
}

class getClipper extends CustomClipper<Path>
{
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height/2.4);
    path.lineTo(size.width + 554, 0.0);
    path.close();
    return path;
  }
}