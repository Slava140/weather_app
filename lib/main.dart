import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(const JoraApp());
}

class JoraApp extends StatelessWidget {
  const JoraApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(primary: Colors.black),
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
      home: const HomeScreen(title: 'Flutter Demo Home Page'),

    );
  }
}