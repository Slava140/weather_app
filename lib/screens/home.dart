import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sem2/models/weather.dart';
import 'package:sem2/utils/utils.dart';
import 'package:sem2/utils/weather.dart';

import '../utils/notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PreferencesService prefs = PreferencesService();
  Future<String?>? futureLoggedInLogin;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      setState(() {
        futureLoggedInLogin = prefs.getLoggedInLogin();
      });
      _loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();
    final notificationsService = WeatherNotificationService();
    notificationsService.init();

    final weatherFuture = fetchWeather(controller.city);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.city,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 24),
                ),
                FutureBuilder(
                  future: futureLoggedInLogin,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Text(snapshot.data.toString());
                    } else {
                      return const Text('');
                    }
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.map_outlined),
                      onPressed: () {
                        Navigator.pushNamed(context, '/search');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.account_circle_outlined),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 48),
            Column(
              children: [
                Text(
                  getFormattedDate(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
                FutureBuilder<WeatherResponse>(
                  future: weatherFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.current.tempC.toInt().toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 96),
                      );
                    } else {
                      return const Text('Нет данных');
                    }
                  },
                ),
              ],
            ),
            FutureBuilder<WeatherResponse>(
              future: weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Image.network(
                    'https:${snapshot.data!.current.condition.iconUrl}',
                    width: 128,
                    height: 128,
                  );
                } else {
                  return const Text('Нет данных');
                }
              },
            ),
            FutureBuilder<WeatherResponse>(
              future: weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text(
                    snapshot.data!.current.condition.text,
                    style: const TextStyle(fontSize: 18),
                  );
                } else {
                  return const Text('Нет данных');
                }
              },
            ),
            const SizedBox(height: 48),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/details');
              },
              child: const Text(
                'Подробнее',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
