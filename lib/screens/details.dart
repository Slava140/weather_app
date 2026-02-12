import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sem2/models/weather.dart';
import 'package:sem2/utils/utils.dart';
import 'package:sem2/utils/weather.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();
    final weatherFuture = fetchWeather(controller.city);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Text(
                      controller.city,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
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
                      icon: const Icon(Icons.settings_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 96),
            FutureBuilder<WeatherResponse>(
              future: weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Скорость ветра', style: TextStyle(fontSize: 16)),
                          Text(
                            '${(snapshot.data!.current.windKph * 1000 / 3600).toInt()} м/с',
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Влажность', style: TextStyle(fontSize: 16)),
                          Text(
                            '${snapshot.data!.current.humidity.toInt()}%',
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Видимость', style: TextStyle(fontSize: 16)),
                          Text(
                            '${snapshot.data!.current.visKm.toInt()} Км',
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Давление', style: TextStyle(fontSize: 16)),
                          Text(
                            '${(snapshot.data!.current.pressureMb * 0.750062).toInt()} мм.рт.ст',
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Text('Нет данных');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
