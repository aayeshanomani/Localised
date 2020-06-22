import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
        backgroundColor: Colors.grey[400],
        appBar: AppBar
        (
        title: Text
          (
            'Payment',
              style: TextStyle(color: Colors.grey)
          ),
        backgroundColor: Colors.grey[600],
        elevation: 0.0,
        ),
      body: Container
        (
        child: Center
          (
          child: RaisedButton
            (
            color: Colors.grey[700],
            child: Text
              (
              'Pay',
              style: TextStyle(color: Colors.grey[800]),
            ),
            onPressed: ()
            {

            },
          ),
        ),
      ),
    );
  }
}
