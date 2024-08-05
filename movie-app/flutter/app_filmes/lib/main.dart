import 'package:app_filmes/firebase_options.dart';
import 'package:app_filmes/models/user_model.dart';
import 'package:app_filmes/screens/home_screen.dart';
import 'package:app_filmes/screens/login_screen.dart';
import 'package:app_filmes/services/firebase/auth/firebase_auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flixflix',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black45,
      ),
      // home: const HomeScreen(),
      home: InitializeApp(),
    );
  }
}

class InitializeApp extends StatelessWidget {
  final FirebaseAuthService _auth = FirebaseAuthService();

  InitializeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: _auth.user,
        builder: (
            context,
            snapshot
            ) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }

          return LoginPage();
        },
    );
  }
}
