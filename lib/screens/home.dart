import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
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
            SizedBox(height: 48),
            Column(
              children: [
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
            Icon(
              Icons.cloud_outlined,
              size: 128,
            ),
            Text(
              'Слабый дождь',
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            SizedBox(height: 48),
            TextButton(
                onPressed: () => {
                  Navigator.pushNamed(
                      context, '/details'
                  )
                },
                child: Text(
                  'Подробнее',
                  style: TextStyle(fontSize: 24),
                )
            ),
          ],
        ),
      )
    );
  }
}