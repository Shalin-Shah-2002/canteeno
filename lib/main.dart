import 'package:canteeno/models/firebase_auth.dart';
import 'package:canteeno/models/payment_provider.dart';
import 'package:canteeno/models/profile_backend.dart';
import 'package:canteeno/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canteeno/models/adding_removing.dart';
import 'package:canteeno/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<FirebaseAuthentication>(
            create: (context) => FirebaseAuthentication(),
          ),
          ChangeNotifierProvider<AddingRemoving>(
              create: (context) => AddingRemoving()),
          ChangeNotifierProvider<ProfileBackend>(
            create: (context) => ProfileBackend(),
          ),
          ChangeNotifierProvider<PaymentModel>(
            create: (context) => PaymentModel(),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false, home: AuthWrapper()));
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<FirebaseAuthentication>(context);

    return StreamBuilder<User?>(
      stream: authService.userChanges, // This listens to user state changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        // If the user is signed in, show HomeScreen; otherwise, show LoginScreen
        return snapshot.hasData ? SnackOrderScreen() : AnimatedLoginScreen();
      },
    );
  }
}
