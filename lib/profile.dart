//import 'dart:html';

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localised/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Auth _auth = Auth();
  File sampleImage;

  Future getImage() async
  {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            top: MediaQuery.of(context).size.height/4.7,
            left: MediaQuery.of(context).size.width/16,
            child: Column
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
                      image: sampleImage == null ? NetworkImage('https://wallpapercave.com/wp/wp5174771.jpg')
                      : Image.file(sampleImage),
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
                  'Shop',
                  style: TextStyle
                  (
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato'
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
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton
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
      ),
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