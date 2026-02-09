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

    await _notificationsPlugin.initialize(settings: settings);

    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        _notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.requestNotificationsPermission();
  }

  Future<void> sendWeatherAlerts(WeatherResponse weather) async {
    bool hasAlerts = false;

    if (weather.current.tempC >= 30) {
      hasAlerts = true;
      await _showNotification(
        1,
        'Жаркая погода',
        'Сейчас ${weather.current.tempC.toInt()}°C. Пейте больше воды и избегайте солнца.',
      );
    }

    if (weather.current.windKph >= 35) {
      hasAlerts = true;
      await _showNotification(
        2,
        'Сильный ветер',
        'Скорость ветра ${weather.current.windKph.toInt()} км/ч. Будьте осторожны на улице.',
      );
    }

    if (!hasAlerts) {
      await _showNotification(
        0,
        'Погода обновлена',
        'Сейчас в ${weather.location.name} ${weather.current.tempC.toInt()}°C, ветер ${weather.current.windKph.toInt()} км/ч.',
      );
    }
  }

  Future<void> _showNotification(int id, String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'weather_alerts_channel',
      'Погодные уведомления',
      channelDescription: 'Уведомления о погодных изменениях',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }
}
