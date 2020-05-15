import 'package:flutter/material.dart';
import 'package:localised/constants.dart';

import 'auth.dart';

class CustRegister extends StatefulWidget {

  final Function toggleView;
  CustRegister({
    this.toggleView
  });

  @override
  _CustRegisterState createState() => _CustRegisterState();
}

class _CustRegisterState extends State<CustRegister> {

  final Auth _auth = Auth();
  final _formKey = GlobalKey<FormState>();

  String email ="";
  String password = "";
  String confirmPassword = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent[100],
      appBar: AppBar
      (
        backgroundColor: Colors.indigoAccent,
        elevation: 0.0,
        title: Text
        (
          'Sign Up',
        ),
        actions: <Widget>[
          FlatButton.icon
          (
            onPressed: ()
            {
              widget.toggleView();
            }, 
            icon: Icon(Icons.person), 
            label: Text('Sign In'),
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

              validator: (val) => val.isEmpty ? 'Enter an Email' : null,
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
                validator: (val) => val.length<6 ? 'Password should be 6 characters at least' : null,
              ),
              SizedBox(height: 20.0,),
              TextFormField
              (
                decoration: textInputDecoration.copyWith(hintText: 'Confirm Password'),
                onChanged: (val)
                {
                  setState(() {
                    confirmPassword = val;
                  });
                },
                obscureText: true,
                validator: (val) => val != password ? 'Passwords don\'t match' : null,
              ),
              SizedBox(height: 20.0,),
              RaisedButton
              (
                color: Colors.indigoAccent,
                child: Text
                (
                  'Sign up',
                  style: TextStyle(color: Colors.lightBlue[200]),
                ),
                onPressed: () async
                {
                  if(_formKey.currentState.validate())
                  {
                    dynamic result = await _auth.SignUpEmailPassword(email, password);
                    if(result == null)
                    {
                      setState(() {
                        error = "Enter a valid email";
                      });
                    }
                  }
                }
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