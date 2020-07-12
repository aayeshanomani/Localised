import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'service_payment.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  Future<void> _showMyDialog() async 
  {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Transaction Status'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Payment Successfull'),
                Text('Amount: \u20B9300 Paid'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  onItemPressed(BuildContext context, int index)
  {
    print("index "+ index.toString());
    switch(index)
    {
      case 0:
        var response = StripeService.payWithNewCard
        (
          amount: '300',
          currency: 'INR'
        );
        if(response.success == true)
        {
          _showMyDialog();
        }
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => CardScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.redAccent[700]),
    );
    ThemeData themeData = Theme.of(context);
    return Scaffold
    (
      backgroundColor: Colors.white,
      appBar: AppBar
      (
        title: Center(
          child: Text
          (
            'Payment',
              style: TextStyle(color: Colors.white)
          ),
        ),
        backgroundColor: Colors.redAccent,
        elevation: 6.0,
      ),
      body: Container
      (
        child: Center
          (
          child: ListView.separated
          (
            itemBuilder: (context, index)
            {
              Icon icon;
              Text text;
              
              switch(index)
              {
                case 0:
                  icon = Icon(Icons.add_circle, color: Colors.deepOrange[500],);
                  text = Text('Pay with a new card');
                  break;
                case 1:
                  icon = Icon(Icons.credit_card, color: Colors.deepOrange[500],);
                  text = Text('Pay with existing card');
                  break;
              }

              return InkWell
              (
                onTap: ()
                {
                  onItemPressed(context, index);
                },
                child: ListTile
                (
                  title: text,
                  leading: icon,
                ),
              );
            }, 
            separatorBuilder: (context, index) => Divider
            (
              color: Colors.deepOrange[400],
            ), 
            itemCount: 2
          )
        ),
      ),
    );
  }
}

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {

  List cards = 
  [{
    'cardNumber': '5555555555554444',
    'expiryDate': '4/24',
    'cardHolderName': 'test',
    'cvvCode': '928',
    'showBackView': false
  },
  {
    'cardNumber': '4242424242424242',
    'expiryDate': '4/24',
    'cardHolderName': 'test',
    'cvvCode': '928',
    'showBackView': false
  }];

  @override
  void initState() {
    super.initState();
    StripePayment.setOptions
    (
      StripeOptions
      (
        publishableKey: 'pk_test_51H1rLBAGX126C26eQvmNdtd7Chi3adOp5s9lVBil6gDXU0qTO2o8c5pkmry1MGjGRkSKmXbnUSBYgWRjQFiSnU6p00vawi8gRc',
      )
    );
  }

  payWithCard(BuildContext context, card)
  {
    Navigator.pop(context);
    var response = StripeService.payWithExistingCard
    (
      amount: '300',
      currency: 'INR',
      card: card
    );
    if(response.success == true)
    {
      _showMyDialog();
    }
  }

  Future<void> _showMyDialog() async 
  {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Transaction Status'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Payment Successfull'),
                Text('Amount: \u20B9300 Paid'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.redAccent[400]),
    );
    ThemeData themeData = Theme.of(context);
    return Scaffold
    (
      backgroundColor: Colors.white,
      appBar: AppBar
      (
        title: Text
        (
          'Pay',
            style: TextStyle(color: Colors.white)
        ),
        backgroundColor: Colors.redAccent,
        elevation: 6.0,
      ),
      body: Container
      (
        padding: EdgeInsets.all(29.0),
        child: ListView.builder
        (
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int index)
          {
            var card = cards[index];
            return InkWell
            (
              onTap: ()
              {
                payWithCard(context, card);
              },
              child: CreditCardWidget
              (
                cardNumber: card['cardNumber'],
                expiryDate: card['expiryDate'], 
                cardHolderName: card['cardHolderName'],
                cvvCode: card['cvvCode'],
                showBackView: false, //true when you want to show cvv(back) view
              ),
            );
          }
        ),
      ),
    );
  }
}