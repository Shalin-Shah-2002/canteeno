import 'package:canteeno/models/firebase_auth.dart';
import 'package:canteeno/screens/login_screen.dart';
import 'package:canteeno/screens/reg_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false, home: AnimatedLoginScreen()));
  }
}
