
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteeno/screens/homepage.dart';

class FirebaseAuthentication extends ChangeNotifier {
  FirebaseAuth Authinstance = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? _user;

  User? get user => _user;

  FirebaseAuthentication() {
    Authinstance.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> Register(String username, String email, String password) async {
    try {
      UserCredential credential =
          await Authinstance.createUserWithEmailAndPassword(
              email: email, password: password);
      if (credential != null) {
        await firestore
            .collection('User')
            .doc(credential.user?.uid)
            .collection('Reginfo')
            .doc(username)
            .set({
          'username': username,
          'email': email,
          'createdat': Timestamp.now()
        });
      } else {
        print('User creation failed: user is null.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> Login(String email, String password) async {
    try {
      await Authinstance.signInWithEmailAndPassword(
          email: email, password: password);

      
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> Signout() async {
    await Authinstance.signOut();
  }

  void _onAuthStateChanged(User? user) {
    if (user != null) {
      _user = user;
    } else {
      _user = null;
    }
    notifyListeners();
  }
}
