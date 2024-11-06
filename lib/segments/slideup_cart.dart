import 'package:canteeno/screens/payment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:canteeno/models/adding_removing.dart'; // Assumi
import 'package:canteeno/models/payment_provider.dart'; // Assuming you have this class managing adding/removing items.

void showCartBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      // Accessing the cart data using Provider.
      var addremove = Provider.of<AddingRemoving>(context, listen: true);
      final paymentModel = Provider.of<PaymentModel>(context);

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Cart',
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            addremove.cartItemCount == 0
                ? Center(
                    child: Text(
                      'Your cart is empty',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: addremove.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = addremove.cartItems[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.orange[100],
                            child: Text(
                              item['quantity'].toString(),
                              style: GoogleFonts.poppins(color: Colors.black),
                            ),
                          ),
                          title: Text(
                            item['food_name'],
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            '\$${item['price']}',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.black54),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle,
                                color: Colors.red),
                            onPressed: () {
                              addremove.Remove(item['food_name']);
                            },
                          ),
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${addremove.totalPrice}',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentScreen()),
                    );
                    paymentModel.updateAmount(addremove.totalPrice.toString());
                    print('Amount: ${paymentModel.amount}');
                  },
                  child: Text(
                    'Checkout',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
