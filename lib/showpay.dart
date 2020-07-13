import 'package:Localised/payment.dart';
import 'package:flutter/material.dart';

class ShowPay extends StatefulWidget {
  @override
  _ShowPayState createState() => _ShowPayState();
}

class _ShowPayState extends State<ShowPay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Subscription')),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Text(
                    'Get benefits of Localised for 90 days',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Lato'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'For only \u20B9300',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Lato'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 22.0),
                  child: new Image(
                      width: 400.0,
                      height: 319.0,
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/pay.jpg')),
                ),
                Padding(
                  padding: const EdgeInsets.all(55.0),
                  child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(57.0))),
                    color: Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 42.0),
                      child: Text(
                        "Pay",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontFamily: "Lato"),
                      ),
                    ),
                    onPressed: () 
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen()));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
