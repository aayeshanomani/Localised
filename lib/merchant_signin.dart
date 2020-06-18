import 'package:flutter/material.dart';
import 'package:localised/auth.dart';
import 'package:localised/constants.dart';
import 'package:localised/customer_home.dart';
import 'package:localised/loading.dart';
import 'package:localised/wrapper.dart';

class Merch_SignIn extends StatefulWidget {

  final Function toggleView;
  Merch_SignIn({
    this.toggleView
  });

  @override
  _Merch_SignInState createState() => _Merch_SignInState();
}

class _Merch_SignInState extends State<Merch_SignIn> {

  final Auth _auth = Auth();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.indigoAccent[100],
      appBar: AppBar
      (
        backgroundColor: Colors.indigoAccent,
        elevation: 0.0,
        title: Text
        (
          'Sign In',
        ),
        actions: <Widget>[
          FlatButton.icon
          (
            onPressed: ()
            {
              widget.toggleView();
            }, 
            icon: Icon(Icons.person), 
            label: Text('Sign Up'),
          ),
        ],
      ),
      body: Container
      (
        padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
        child: Form
        (
          key: _formKey,
          child: Column
          (
            children: <Widget>
            [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter Email'),
                onChanged: (val)
                {
                  setState(() {
                    email = val;
                  });
                },

                validator: (val) => val.isEmpty ? 'Enter your Email' : null,
              ),
              SizedBox(height: 20.0,),
              TextFormField
              (
                decoration: textInputDecoration.copyWith(hintText: 'Enter Password'),
                onChanged: (val)
                {
                  setState(() {
                    password = val;
                  });
                },
                obscureText: true,
                validator: (val) => val.isEmpty ? 'Enter the Password' : null,
              ),
              SizedBox(height: 20.0,),
              GestureDetector(
                child: Text
                  (
                  "Forgot Password",
                  style: TextStyle
                    (
                    color: Colors.blueGrey[50],
                  ),
                ),
                onTap: ()
                {

                },
              ),
              SizedBox(height: 10.0,),
              RaisedButton
              (
                color: Colors.indigoAccent,
                child: Text
                (
                  'Sign in',
                  style: TextStyle(color: Colors.lightBlue[200]),
                ),
                onPressed: () async
                {
                  if(_formKey.currentState.validate())
                  {
                    setState(() 
                    {
                      loading = true;
                    });
                    dynamic result = await _auth.SignInEmailPassword(email, password);
                    if(result == null)
                    {
                      setState(() {
                        loading = false;
                        error = "Enter a registered email";
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 10.0,),
              RaisedButton
                (
                color: Colors.white,
                child: Text
                  (
                  'Sign in with Google',
                  style: TextStyle(color: Colors.purple),
                ),
                onPressed: ()
                {

                },
              ),
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle
                (
                  color: Colors.black,
                  fontSize: 14.0
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}