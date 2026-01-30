import 'dart:convert';

import 'package:http/http.dart' as http;
import '/models/weather.dart';

Future<WeatherResponse> fetchWeather(String apiKey, String city) async {
  final response = await http.get(
    Uri.parse('https://api.weatherapi.com/v1/current.json?q=$city&lang=ru&key=$apiKey'),
  );

  print(response.statusCode);
  if (response.statusCode == 200) {
    var r = WeatherResponse.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
    print(r);
    return r;
  } else {
    throw Exception('Ошибка при загрузке');
  }
}

