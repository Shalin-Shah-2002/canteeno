import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canteeno/models/payment_provider.dart';
import 'package:canteeno/models/adding_removing.dart'; //
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paymentModel = Provider.of<PaymentModel>(context);
    var addremove = Provider.of<AddingRemoving>(context, listen: true);

    String Payable_amount = addremove.totalPrice.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("UPI Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total: \$${addremove.totalPrice}',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            // TextField(
            //   decoration: InputDecoration(labelText: "Amount"),
            //   keyboardType: TextInputType.number,
            //   onChanged: (value) {
            //     paymentModel.updateAmount(value);
            //   },
            // ),
            TextField(
              decoration: InputDecoration(labelText: "Note"),
              onChanged: (value) {
                paymentModel.updateNote(value);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await paymentModel.initiateTransaction(
                    "com.google.android.apps.nbu.paisa.user"); // Google Pay package
              },
              child: Text("Pay with Google Pay"),
            ),
            ElevatedButton(
              onPressed: () async {
                await paymentModel
                    .initiateTransaction("net.one97.paytm"); // Paytm package
              },
              child: Text("Pay with Paytm"),
            ),
            ElevatedButton(
              onPressed: () async {
                await paymentModel
                    .initiateTransaction("com.phonepe.app"); // PhonePe package
              },
              child: Text("Pay with PhonePe"),
            ),
          ],
        ),
      ),
    );
  }
}
