import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MoodBitesApp());
}

class MoodBitesApp extends StatelessWidget {
  const MoodBitesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoodBites',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFFFF1E6),
        textTheme: const TextTheme(bodyMedium: TextStyle(fontFamily: 'Arial')),
      ),
      home: const WelcomeScreen(),
    );
  }
}
