import 'package:flutter/material.dart';
import 'package:flutter_upi_india/flutter_upi_india.dart';

class PaymentModel with ChangeNotifier {
  String _amount = "0";
  String _note = "Payment for service";
  String _upiId = "2002shalin@okhdfcbank";

  String get amount => _amount;
  String get note => _note;

  void updateAmount(String newAmount) {
    _amount = newAmount;
    notifyListeners();
  }

  void updateNote(String newNote) {
    _note = newNote;
    notifyListeners();
  }

  Future<void> initiateTransaction(String appPackageName) async {
    try {
      UpiPay.initiateTransaction(
        amount: '100.00',
        app: UpiApplication.googlePay,
        receiverName: 'Shalin Shah',
        receiverUpiAddress: '2002shalin@okhdfcbank',
        transactionRef: 'UPITXREF0001',
        transactionNote: 'A UPI Transaction',
      ).then((response) {
        // Log or handle the response here
        print("Transaction Response: $response");
      });
    } catch (e) {
      print("Error: $e");
    }
  }
}
