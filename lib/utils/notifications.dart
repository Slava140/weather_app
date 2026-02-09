import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sem2/models/weather.dart';

class WeatherNotificationService {
  static const MethodChannel _channel = MethodChannel('weather_notifications');

  Future<void> init() async {}

  Future<void> sendWeatherAlerts(WeatherResponse weather) async {
    if (weather.current.tempC >= 30) {
      await _showNotification(
        'Жаркая погода',
        'Сейчас ${weather.current.tempC.toInt()}°C. Пейте больше воды и избегайте солнца.',
      );
    }

    if (weather.current.windKph >= 35) {
      await _showNotification(
        'Сильный ветер',
        'Скорость ветра ${weather.current.windKph.toInt()} км/ч. Будьте осторожны на улице.',
      );
    }
  }

  Future<void> _showNotification(String title, String body) async {
    if (!Platform.isAndroid) {
      return;
    }

    try {
      await _channel.invokeMethod('showNotification', {
        'title': title,
        'body': body,
      });
    } catch (_) {}
  }
}
