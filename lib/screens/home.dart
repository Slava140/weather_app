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
  String? _loggedInLogin;
  bool _isProfileLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLoggedInLogin();
  }

  Future<void> _loadLoggedInLogin() async {
    final login = await prefs.getLoggedInLogin();
    if (mounted) {
      setState(() {
        _loggedInLogin = login;
        _isProfileLoading = false;
      });
    }
  }

  Future<void> _handleProfileAction(_ProfileMenuAction action) async {
    if (action == _ProfileMenuAction.logIn) {
      await Navigator.pushNamed(context, '/login');
      await _loadLoggedInLogin();
      return;
    }

    if (action == _ProfileMenuAction.logOut) {
      await prefs.clearLoggedInProfileCredentials();
      await _loadLoggedInLogin();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Вы вышли из профиля')),
      );
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
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.map_outlined),
                      onPressed: () {
                        Navigator.pushNamed(context, '/search');
                      },
                    ),
                    PopupMenuButton<_ProfileMenuAction>(
                      icon: const Icon(Icons.account_circle_outlined),
                      onSelected: _handleProfileAction,
                      itemBuilder: (context) {
                        if (_isProfileLoading) {
                          return const [
                            PopupMenuItem<_ProfileMenuAction>(
                              enabled: false,
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          ];
                        }

                        if (_loggedInLogin != null) {
                          return [
                            PopupMenuItem<_ProfileMenuAction>(
                              enabled: false,
                              child: Text(_loggedInLogin!),
                            ),
                            const PopupMenuDivider(),
                            const PopupMenuItem<_ProfileMenuAction>(
                              value: _ProfileMenuAction.logOut,
                              child: Text('Выйти...'),
                            ),
                          ];
                        }

                        return const [
                          PopupMenuItem<_ProfileMenuAction>(
                            value: _ProfileMenuAction.logIn,
                            child: Text('Войти...'),
                          ),
                        ];
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

enum _ProfileMenuAction { logIn, logOut }
