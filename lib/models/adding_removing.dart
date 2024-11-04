import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddingRemoving extends ChangeNotifier {
  FirebaseFirestore storeinstance = FirebaseFirestore.instance;
  FirebaseAuth Authinstance = FirebaseAuth.instance;
  List<Map<String, dynamic>> cartItems = [];

  String? _count;
  String? get count => _count;

  double totalPrice = 0.0;
  double get _totalPrice => totalPrice;

  int totalQuantity = 0;
  int get _totalQuantity => totalQuantity;

  Stream<int> get cartItemCount {
    return storeinstance
        .collection('User')
        .doc(Authinstance.currentUser?.uid)
        .collection('cart')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Future Add(String foodName, String price, String quantity) async {
    try {
      await storeinstance
          .collection('User')
          .doc(Authinstance.currentUser?.uid)
          .collection('cart')
          .doc(foodName)
          .set({'food_name': foodName, 'price': price, 'quantity': quantity});
      fetchAllDocuments();
    } catch (e) {
      print(e.toString());
    }

    
  }

  Future<void> Remove(String foodName) async {
    try {
      await storeinstance
          .collection('User')
          .doc(Authinstance.currentUser?.uid)
          .collection('cart')
          .doc(foodName)
          .delete();
      print('Item removed successfully');
      fetchAllDocuments();
    } catch (e) {
      print('Error removing item: $e');
    }
  }

  Future<void> fetchAllDocuments() async {
    try {
      final userId = Authinstance.currentUser?.uid;
      print('Current User UID: $userId');

      QuerySnapshot querySnapshot = await storeinstance
          .collection('User')
          .doc(userId)
          .collection('cart')
          .get();

      print('Total documents: ${querySnapshot.docs.length}');

      cartItems.clear();

      for (var doc in querySnapshot.docs) {
        cartItems.add({
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        });
      }

      calculateTotal();

      notifyListeners();

      print('Cart Items: $cartItems');
    } catch (e) {
      print('Error fetching documents: $e');
    }
  }

  void calculateTotal() {
    totalQuantity = 0;
    totalPrice = 0.0;

    for (var item in cartItems) {
      int quantity = int.tryParse(item['quantity'] ?? '0') ?? 0;
      double price = double.tryParse(item['price'] ?? '0.0') ?? 0.0;

      totalPrice += price * quantity;

      totalQuantity += quantity;
    }


    print('Total Quantity: $totalQuantity');
    print('Total Price: \$${totalPrice.toStringAsFixed(2)}');
  }
}
