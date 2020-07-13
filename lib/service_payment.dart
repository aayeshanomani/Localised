import 'dart:convert';

import 'package:Localised/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class TransactionResponse {
  String message;
  bool success;

  TransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
      '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';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    try {
      StripePayment.setOptions(StripeOptions(
          publishableKey:
              "pk_live_51H1rLBAGX126C26eA1ETYtqWHaxR9JeMXaC7N6owvPoo66gjb6hnw7kFFv8OWeqClHG1epftr6fS8XqUOSinc4Sn00Ha4gm82z",
          merchantId: "Schaffen Software",
          androidPayMode: 'test'));
    } catch (e) {
      print(e.toString());
    }
  }

  static TransactionResponse payWithExistingCard(
      {String amount, String currency, card}) {
    return new TransactionResponse(
        message: 'Transaction Successful', success: true);
  }

  static Future<TransactionResponse> payWithNewCard(
      {String amount, String currency, context}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        final CollectionReference location =
            Firestore.instance.collection('locations');
        final user = Provider.of<User>(context);
        location.document(user.uid).updateData({
          'subsDate': DateTime.now().millisecondsSinceEpoch.toString(),
          'expDate':
              (DateTime.now().millisecondsSinceEpoch + 90 * 24 * 60 * 60 * 1000)
                  .toString(),
          'payment': true
        });
        return new TransactionResponse(
            message: 'Transaction Successful', success: true);
      } else {
        return new TransactionResponse(
            message: 'Transaction Failed', success: false);
      }
    } on PlatformException catch (e) {
      return StripeService.getPlatformException(e);
    } catch (e) {
      print(e.toString());
      return new TransactionResponse(
          message: 'Transaction Failed: ' + e.toString(), success: false);
    }
  }

  static getPlatformException(e) {
    String message = 'Something went wrong.';
    if (e.code == 'cancelled') {
      message = message + '\nTransaction cancelled.';
    }
    return new TransactionResponse(message: message, success: false);
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    Map<String, dynamic> body = {
      'amount': amount,
      'currency': currency,
      'payment_method_types[]': 'card'
    };
    try {
      var response = await http.post(StripeService.paymentApiUrl,
          body: body, headers: StripeService.headers);
      return jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
}
