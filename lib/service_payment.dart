class TransactionResponse
{
  String message;
  bool success;

  TransactionResponse
  ({
    this.message,
    this.success
  });
}

class StripeService
{
  static String apiBase = 'https://api.stripe.com//v1';
  static String secret = '';

  static init()
  {

  }

  static TransactionResponse payWithExistingCard({String amount, String currency, card})
  {
    return new TransactionResponse
    (
      message: 'Transaction Successful',
      success: true
    );
  }

  static TransactionResponse payWithNewCard({String amount, String currency})
  {
    return new TransactionResponse
    (
      message: 'Transaction Successful',
      success: true
    );
  }
}