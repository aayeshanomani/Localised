import 'package:Localised/wrapper.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<void> _showMyDialog() async {
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

  Future<void> _showMyDialogFail(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Transaction Status'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                //Text('Payment Failed'),
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Wrapper()));
              },
            ),
          ],
        );
      },
    );
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style:
            TextStyle(color: Colors.black, fontSize: 16.0, fontFamily: "Lato"),
      ),
      backgroundColor: Colors.deepOrange[50],
      duration: Duration(seconds: 3),
    ));
  }

  onItemPressed(BuildContext context, int index) async {
    print("index " + index.toString());
    switch (index) {
      case 0:
        var response = await StripeService.payWithNewCard(
            amount: '30000', currency: 'INR', context: context);
        if (response.success == true) {
          showInSnackBar("Transaction Successful");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Wrapper()));
        } else {
          _showMyDialogFail(response.message);
        }
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CardScreen()));
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.redAccent[700]),
    );

    ThemeData themeData = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Payment', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        elevation: 6.0,
      ),
      body: Container(
        child: Center(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  Icon icon;
                  Text text;

                  switch (index) {
                    case 0:
                      icon = Icon(
                        Icons.add_circle,
                        color: Colors.deepOrange[500],
                      );
                      text = Text('Pay with a new card');
                      break;
                    case 1:
                      icon = Icon(
                        Icons.credit_card,
                        color: Colors.deepOrange[500],
                      );
                      text = Text('Pay with existing card');
                      break;
                  }

                  return InkWell(
                    onTap: () {
                      onItemPressed(context, index);
                    },
                    child: ListTile(
                      title: text,
                      leading: icon,
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      color: Colors.deepOrange[400],
                    ),
                itemCount: 2)),
      ),
    );
  }
}

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  List cards = [];

  @override
  void initState() {
    super.initState();
    StripePayment.setOptions(StripeOptions(
      publishableKey:
          'pk_test_51H1rLBAGX126C26eQvmNdtd7Chi3adOp5s9lVBil6gDXU0qTO2o8c5pkmry1MGjGRkSKmXbnUSBYgWRjQFiSnU6p00vawi8gRc',
    ));
  }

  payWithCard(BuildContext context, card) {
    Navigator.pop(context);
    var response = StripeService.payWithExistingCard(
        amount: '30000', currency: 'INR', card: card);
    if (response.success == true) {
      _showMyDialog();
    }
  }

  Future<void> _showMyDialog() async {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pay', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        elevation: 6.0,
      ),
      body: cards.length < 1
          ? Center(
              child: Text('It\'s all empty here.'),
            )
          : Container(
              padding: EdgeInsets.all(29.0),
              child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (cards.length < 1) {
                      return Center(
                        child: Text('It\'s all empty here.'),
                      );
                    }
                    var card = cards[index];
                    return InkWell(
                      onTap: () {
                        payWithCard(context, card);
                      },
                      child: CreditCardWidget(
                        cardNumber: card['cardNumber'],
                        expiryDate: card['expiryDate'],
                        cardHolderName: card['cardHolderName'],
                        cvvCode: card['cvvCode'],
                        showBackView:
                            false, //true when you want to show cvv(back) view
                      ),
                    );
                  }),
            ),
    );
  }
}
