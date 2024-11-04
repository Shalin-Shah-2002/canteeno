import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileBackend extends ChangeNotifier {
  FirebaseFirestore firestoreinstace = FirebaseFirestore.instance;
  FirebaseAuth fireauthinstace = FirebaseAuth.instance;

  String? _username;
  String? get username => _username;

  String? _email;
  String? get email => _email;

  Future<void> Profile() async {
    try {
      QuerySnapshot querySnapshot = await firestoreinstace
          .collection('User')
          .doc(fireauthinstace.currentUser?.uid)
          .collection('Reginfo')
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        _username = doc.get('username');
        _email = doc.get('email');
        print('Username: $username');
        print('Email: $email');

        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
