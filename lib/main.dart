import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:sem2/screens/login.dart';
import 'package:sem2/screens/registration.dart';
import 'package:sem2/utils/notifications.dart';
import 'package:sem2/utils/utils.dart';

import 'screens/details.dart';
import 'screens/home.dart';
import 'screens/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefsService = PreferencesService();
  final weatherController = WeatherController(prefsService);
  final notificationsService = WeatherNotificationService();

  await weatherController.load();
  await notificationsService.init();
  await initializeDateFormatting('ru', null);

  runApp(
    ChangeNotifierProvider.value(
      value: weatherController,
      child: const JoraApp(),
    ),
  );
}

class JoraApp extends StatelessWidget {
  const JoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();

    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(colorScheme: ColorScheme.highContrastDark()),
      initialRoute: '/',
      routes: {
        '/': (context) =>
            controller.hasCity ? const HomeScreen() : const SearchScreen(),
        '/details': (context) =>
            controller.hasCity ? const DetailsScreen() : const SearchScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/search': (context) => const SearchScreen(),
      },
    );
  }
}
