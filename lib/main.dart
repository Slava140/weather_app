import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:sem2/models/weather.dart';
import 'package:sem2/screens/login.dart';
import 'package:sem2/screens/registration.dart';
import 'package:sem2/utils/utils.dart';
import 'package:sem2/utils/weather.dart';

import 'screens/home.dart';
import 'screens/details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefsService = PreferencesService();
  final weatherController = WeatherController(prefsService);
  await weatherController.load();

  String? loggedInLogin = await prefsService.getLoggedInLogin();
  bool isLoggedIn = loggedInLogin != null;
  initializeDateFormatting('ru', null);

  runApp(
      ChangeNotifierProvider.value(
        value: weatherController,
        child: JoraApp(isLoggedIn: isLoggedIn),
      )
  );
}

class JoraApp extends StatelessWidget {
  final bool isLoggedIn;

  const JoraApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final controller = context.read<WeatherController>();
    final Future<WeatherResponse> futureWeather = fetchWeather(controller.city);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.highContrastDark()
      ),
      initialRoute: isLoggedIn ? '/' : '/login',
      routes: {
        '/': (context) => HomeScreen(futureWeather: futureWeather),
        '/details': (context) => DetailsScreen(futureWeather: futureWeather),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
      },
      // home: const HomeScreen(),

    );
  }
}