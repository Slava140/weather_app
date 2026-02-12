import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sem2/models/weather.dart';
import 'package:sem2/utils/notifications.dart';
import 'package:sem2/utils/utils.dart';
import 'package:sem2/utils/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PreferencesService _prefs = PreferencesService();
  String? _loggedInLogin;
  bool _isProfileLoading = true;

  @override
  void initState() {
    super.initState();
    WeatherNotificationService().init();
    _loadLoggedInLogin();
  }

  Future<void> _loadLoggedInLogin() async {
    final login = await _prefs.getLoggedInLogin();
    if (!mounted) return;

    setState(() {
      _loggedInLogin = login;
      _isProfileLoading = false;
    });
  }

  Future<void> _handleProfileAction(_ProfileMenuAction action) async {
    if (action == _ProfileMenuAction.logIn) {
      await Navigator.pushNamed(context, '/login');
      await _loadLoggedInLogin();
      return;
    }

    if (action == _ProfileMenuAction.logOut) {
      await _prefs.removeLoggedInLogin();
      await _loadLoggedInLogin();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Вы вышли из профиля')),
      );
    }
  }

  String _hiResIconUrl(String iconUrl) {
    final normalized = iconUrl.startsWith('//') ? 'https:$iconUrl' : iconUrl;
    return normalized.replaceFirst('/64x64/', '/128x128/');
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();
    final weatherFuture = fetchWeather(controller.city);

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.city, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            icon: const Icon(Icons.travel_explore_rounded),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
          PopupMenuButton<_ProfileMenuAction>(
            icon: const Icon(Icons.account_circle_rounded),
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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<WeatherResponse>(
          future: weatherFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('Нет данных'));
            }

            final weather = snapshot.data!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getFormattedDate(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 12),
                Text(
                  '${weather.current.tempC.toInt()}°',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 96),
                ),
                const SizedBox(height: 8),
                Image.network(
                  _hiResIconUrl(weather.current.condition.iconUrl),
                  width: 128,
                  height: 128,
                  filterQuality: FilterQuality.high,
                ),
                const SizedBox(height: 8),
                Text(
                  weather.current.condition.text,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 40),
                FilledButton.tonal(
                  onPressed: () => Navigator.pushNamed(context, '/details'),
                  child: const Text('Подробнее'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

enum _ProfileMenuAction { logIn, logOut }
