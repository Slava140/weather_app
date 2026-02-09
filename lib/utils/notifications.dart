import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sem2/models/weather.dart';

class WeatherNotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _notificationsPlugin.initialize(settings);

    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        _notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.requestNotificationsPermission();
  }

  Future<void> sendWeatherAlerts(WeatherResponse weather) async {
    if (weather.current.tempC >= 30) {
      await _showNotification(
        1,
        'Жаркая погода',
        'Сейчас ${weather.current.tempC.toInt()}°C. Пейте больше воды и избегайте солнца.',
      );
    }

    if (weather.current.windKph >= 35) {
      await _showNotification(
        2,
        'Сильный ветер',
        'Скорость ветра ${weather.current.windKph.toInt()} км/ч. Будьте осторожны на улице.',
      );
    }
  }

  Future<void> _showNotification(int id, String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'weather_alerts_channel',
      'Погодные уведомления',
      channelDescription: 'Уведомления о погодных изменениях',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(id, title, body, details);
  }
}
