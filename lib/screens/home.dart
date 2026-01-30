import 'package:flutter/material.dart';
import 'package:sem2/models/weather.dart';
import 'package:sem2/utils/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<WeatherResponse> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather(
      '8672369e1dbd452385640544262701',
      'Караганда'
    );
    // print(futureWeather.current.tempC);

  }

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
                FutureBuilder<WeatherResponse>(
                    future: futureWeather,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.current.tempC.toInt().toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 96,
                          ),
                        );
                      } else {
                        return Text('Нет данных');
                      }
                    }
                ),
              ],
            ),
            Icon(
              Icons.cloud_outlined,
              size: 128,
            ),
            FutureBuilder<WeatherResponse>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Text(
                      snapshot.data!.current.condition.text,
                      style: TextStyle(
                          fontSize: 18
                      ),
                    );
                  } else {
                    return Text('Нет данных');
                  }
                }
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