import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:sem2/models/weather.dart';
import 'package:sem2/utils/utils.dart';
import 'package:sem2/utils/weather.dart';

import 'screens/home.dart';
import 'screens/details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefsService = PreferencesService();
  final weatherController = WeatherController(prefsService);
  await weatherController.load();

  initializeDateFormatting('ru', null);

  runApp(
      ChangeNotifierProvider.value(
        value: weatherController,
        child: const JoraApp(),
      )
  );
}

class JoraApp extends StatelessWidget {
  const JoraApp({super.key});

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
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(futureWeather: futureWeather),
        '/details': (context) => DetailsScreen(futureWeather: futureWeather)
      },
      // home: const HomeScreen(),

    );
  }
}