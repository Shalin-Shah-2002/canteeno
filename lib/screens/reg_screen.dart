import 'package:canteeno/main.dart';
import 'package:canteeno/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:canteeno/models/firebase_auth.dart';
import 'package:provider/provider.dart';

class AnimatedRegisterScreen extends StatefulWidget {
  @override
  _AnimatedRegisterScreenState createState() => _AnimatedRegisterScreenState();
}

class _AnimatedRegisterScreenState extends State<AnimatedRegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Initialize controllers directly
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    // Dispose of the controllers when done to avoid memory leaks
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(Icons.person, 'Username', usernameController),
                const SizedBox(height: 20),
                _buildTextField(Icons.email, 'Email', emailController),
                const SizedBox(height: 20),
                _buildTextField(Icons.lock, 'Password', passwordController,
                    obscureText: true, icon2: Icons.remove_red_eye),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    final username = usernameController.text.trim();
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (username.isEmpty || email.isEmpty || password.isEmpty) {
                      // Show an error message or a snackbar to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all fields')),
                      );
                      return;
                    }
                    Provider.of<FirebaseAuthentication>(context, listen: false)
                        .Register(username, email, password);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimatedLoginScreen(),
                        ));
                  },
                  child: const Text(
                    'Already have an account? Log in',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      IconData icon, String hint, TextEditingController controller,
      {bool obscureText = false, IconData? icon2}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: Icon(icon2),
        prefixIcon: Icon(icon, color: Colors.orange),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
