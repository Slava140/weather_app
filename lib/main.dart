import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:sem2/screens/login.dart';
import 'package:sem2/screens/registration.dart';
import 'package:sem2/utils/utils.dart';
import 'package:sem2/utils/weather.dart';
import 'package:sem2/utils/notifications.dart';

import 'screens/home.dart';
import 'screens/details.dart';
import 'screens/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefsService = PreferencesService();
  final weatherController = WeatherController(prefsService);
  final notificationsService = WeatherNotificationService();
  await weatherController.load();
  await notificationsService.init();

  try {
    if (weatherController.hasCity) {
      final weather = await fetchWeather(weatherController.city);
      await notificationsService.sendWeatherAlerts(weather);
    }
  } catch (_) {}

  String? loggedInLogin = await prefsService.getLoggedInLogin();
  bool isLoggedIn = loggedInLogin != null;
  initializeDateFormatting('ru', null);

  runApp(
    ChangeNotifierProvider.value(
      value: weatherController,
      child: JoraApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class JoraApp extends StatelessWidget {
  final bool isLoggedIn;

  const JoraApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.highContrastDark()),
      initialRoute: isLoggedIn ? '/' : '/login',
      routes: {
        '/': (context) => controller.hasCity ? const HomeScreen() : const SearchScreen(),
        '/details': (context) => controller.hasCity ? const DetailsScreen() : const SearchScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/search': (context) => const SearchScreen(),
      },
    );
  }
}
