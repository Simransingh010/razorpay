import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phonpe/payment_success.dart'; // Import your successful payment screen here
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Razorpay Demo',
      home: PaymentPage(), // Use PaymentPage as the initial screen
    );
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // Initialize Razorpay
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    // Register event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  // @override
  // void dispose() {
  //   // Dispose Razorpay instance
  //   _razorpay.clear();
  //   // super.dispose();
  // }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Success" + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
    // print();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentSuccessScreen(),
        ));
    // Navigate to the successful payment screen
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.code} - ${response.message}");
    // Handle payment error if needed
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
    // Handle external wallet if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Razorpay Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Replace key_id with your Razorpay key
            _razorpay.open({
              "key": "rzp_test_jSK56Q3nuxBxAM",
              "amount": 50000, // Amount in paisa (e.g., 50000 paisa = ₹500)
              // Other parameters such as order_id, currency, etc. can be included here
            });
          },
          child: Text('Pay with Razorpay'),
        ),
      ),
    );
  }
}
