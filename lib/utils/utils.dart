import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getFormattedDate() {
  final now = DateTime.now();
  final formatter = DateFormat('EEEE. d MMMM', 'ru');
  return formatter.format(now);
}

class PreferencesService {
  static final _cityKey = 'city';

  Future<void> setCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cityKey, city);
  }

  Future<String> getCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cityKey) ?? 'Караганда';
  }
}


class WeatherController extends ChangeNotifier{
  final PreferencesService prefs;

  String _city = 'Караганда';
  String get city => _city;

  WeatherController(this.prefs);

  Future<void> load() async {
    _city = await prefs.getCity();
    notifyListeners();
  }
}