import 'package:flutter/material.dart';

class DecrementScreen extends StatefulWidget {
  const DecrementScreen({super.key, required this.title});
  final String title;

  @override
  State<DecrementScreen> createState() => _DecrementScreenState();
}

class _DecrementScreenState extends State<DecrementScreen> {
  int _counter = 0;

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextButton(onPressed: _decrementCounter, child: const Text('Sub'),)
            ]
        )
    );
  }
}