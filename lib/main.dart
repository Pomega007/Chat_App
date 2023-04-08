import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:session_13/Login Screen.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: LoginScreen(),
    );
  }
}

