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
        colorScheme: ColorScheme.dark(primary: Colors.orangeAccent),
      ),
      home: const HomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}