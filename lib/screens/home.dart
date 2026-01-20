import 'package:flutter/material.dart';
import 'package:sem2/screens/increment.dart';
import 'package:sem2/screens/decrement.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    IncrementScreen(title: 'Add'),
    DecrementScreen(title: 'Sub'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Караганда',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 24
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.map_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.settings_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          Text(
            'Пятница, 13 июня',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            '22°C',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 96,
            ),
          ),

        ],
      ),
    );
  }
}