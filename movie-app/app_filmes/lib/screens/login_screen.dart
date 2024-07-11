import 'package:app_filmes/screens/home_screen.dart';
import 'package:app_filmes/screens/register_screen.dart';
import 'package:app_filmes/services/firebase/auth/firebase_auth_service.dart';
import 'package:flutter/material.dart';

import '../utils/results.dart';

class LoginPage extends StatelessWidget {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<Results>(
          stream: _auth.resultsLogin,
          builder: (context, snapshot) {
            ErrorResult result = ErrorResult(code: "");

            if (snapshot.data is ErrorResult) {
              result = snapshot.data as ErrorResult;
            }

            if (snapshot.data is LoadingResult) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data is SuccessResult) {
              WidgetsBinding.instance.addPostFrameCallback((_){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              });
            }

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'FlixFlix',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[800],
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[800],
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () {
                        final String email = _emailController.text;
                        final String password = _passwordController.text;
                        _auth.signIn(email, password);
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (result.code.isNotEmpty)
                      Text(
                        result.code == "invalid-email" || result.code == "wrong-password"
                            ? "Invalid Authentication"
                            : "Error",
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        // Action for Terms of Service or Privacy Policy
                      },
                      child: const Text(
                        "Terms of Service | Privacy Policy",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
