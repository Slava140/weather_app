import 'package:flutter/material.dart';

class IncrementScreen extends StatefulWidget {
  const IncrementScreen({super.key, required this.title});
  final String title;

  @override
  State<IncrementScreen> createState() => _IncrementScreenState();
}

class _IncrementScreenState extends State<IncrementScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
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
              TextButton(onPressed: _incrementCounter, child: const Text('Add'),)
            ]
        )
    );
  }
}