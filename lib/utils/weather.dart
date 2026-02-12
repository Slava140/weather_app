import 'dart:convert';

import 'package:http/http.dart' as http;
import '/models/weather.dart';

Future<WeatherResponse> fetchWeather(String city) async {
  String apiKey = '8672369e1dbd452385640544262701';
  final response = await http.get(
    Uri.parse('https://api.weatherapi.com/v1/current.json?q=$city&lang=ru&key=$apiKey'),
  );

  if (response.statusCode == 200) {
    var r = WeatherResponse.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
    return r;
  } else {
    throw Exception('Ошибка при загрузке');
  }
}


Future<List<String>> fetchCitySuggestions(String query) async {
  const String apiKey = '8672369e1dbd452385640544262701';
  final response = await http.get(
    Uri.parse('https://api.weatherapi.com/v1/search.json?q=$query&key=$apiKey'),
  );

  if (response.statusCode != 200) {
    throw Exception('Ошибка при получении списка городов');
  }

  final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
  return data
      .map((item) => item['name'] as String)
      .where((name) => name.isNotEmpty)
      .toSet()
      .toList();
}


