import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ProfileBackend extends ChangeNotifier {
  FirebaseFirestore firestoreinstace = FirebaseFirestore.instance;
  FirebaseAuth fireauthinstace = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

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

  // final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  // final FirebaseAuth fireauthInstance = FirebaseAuth.instance;

  // String? _profilePicUrl;
  // String? get profilePicUrl => _profilePicUrl;

  // Future<void> fetchProfileData() async {
  //   try {
  //     final querySnapshot = await firestoreInstance
  //         .collection('User')
  //         .doc(fireauthInstance.currentUser?.uid)
  //         .collection('Reginfo')
  //         .get();

  //     for (var doc in querySnapshot.docs) {
  //       _profilePicUrl = doc.get('profilePicUrl');
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<String?> uploadProfileImage() async {
  //   try {
  //     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //     if (image == null) return null;

  //     final File imageFile = File(image.path);
  //     final storageref = storage.ref().child('canteen_images/${image.name}');
  //     final uploadTask = storageref.putFile(imageFile);

  //     final snapshot = await uploadTask;
  //     final downloadUrl = await snapshot.ref.getDownloadURL();

  //     // Save URL to Firestore
  //     await firestoreInstance
  //         .collection('User')
  //         .doc(fireauthInstance.currentUser?.uid)
  //         .update({'profilePicUrl': downloadUrl});

  //     _profilePicUrl = downloadUrl;
  //     notifyListeners();

  //     print('File uploaded successfully. Download URL: $downloadUrl');
  //     return downloadUrl;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
}
