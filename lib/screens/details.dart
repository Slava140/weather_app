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
      appBar: AppBar(
        title: Text(controller.city, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            icon: const Icon(Icons.travel_explore_rounded),
            onPressed: () => Navigator.pushNamed(context, '/search'),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailsRow(
                  label: 'Скорость ветра',
                  value: '${(weather.current.windKph * 1000 / 3600).toInt()} м/с',
                ),
                _DetailsRow(
                  label: 'Влажность',
                  value: '${weather.current.humidity.toInt()}%',
                ),
                _DetailsRow(
                  label: 'Видимость',
                  value: '${weather.current.visKm.toInt()} км',
                ),
                _DetailsRow(
                  label: 'Давление',
                  value:
                      '${(weather.current.pressureMb * 0.750062).toInt()} мм.рт.ст',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DetailsRow extends StatelessWidget {
  const _DetailsRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
