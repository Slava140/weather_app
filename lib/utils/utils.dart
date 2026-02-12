import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sem2/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';


String getFormattedDate() {
  final now = DateTime.now();
  final formatter = DateFormat('EEEE. d MMMM', 'ru');
  return formatter.format(now);
}

String encryptPassword(String password) {
  final bytes = utf8.encode(password);
  final hash = sha256.convert(bytes);
  return hash.toString();
}


class PreferencesService {
  static final _cityKey = 'city';
  static final _profileBaseKey = 'profile';
  static final _loggedInProfileLogin = 'loggedInProfileLogin';

  Future<void> setCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cityKey, city);
  }

  Future<String?> getCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cityKey);
  }

  Future<void> setLoggedInLogin(String login) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loggedInProfileLogin, login);
  }

  Future<void> removeLoggedInLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInProfileLogin);
  }

  Future<String?> getLoggedInLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_loggedInProfileLogin);
  }

  Future<void> setProfile(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();
    String passwordHash = encryptPassword(password);
    await prefs.setString('${_profileBaseKey}_$login', passwordHash);
  }

  Future<void> removeProfile(String login) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('${_profileBaseKey}_$login');
  }

  Future<void> clearLoggedInProfileCredentials() async {
    final login = await getLoggedInLogin();
    if (login != null) {
      await removeProfile(login);
    }
    await removeLoggedInLogin();
  }

  Future<ProfileOut?> getProfile(String login) async {
    final prefs = await SharedPreferences.getInstance();
    String? passwordHash = prefs.getString('${_profileBaseKey}_$login');
    if (passwordHash == null) {
      return null;
    }
    return ProfileOut(login: login, passwordHash: passwordHash);
  }
}


class WeatherController extends ChangeNotifier {
  final PreferencesService prefs;

  String _city = '';
  String get city => _city;
  bool get hasCity => _city.isNotEmpty;

  WeatherController(this.prefs);

  Future<void> load() async {
    _city = await prefs.getCity() ?? '';
    notifyListeners();
  }

  Future<void> setCity(String city) async {
    _city = city;
    await prefs.setCity(city);
    notifyListeners();
  }
}


class ProfileController extends ChangeNotifier {
  final PreferencesService prefs;

  ProfileOut? _profile = null;
  ProfileOut? get profile => _profile;

  ProfileController(this.prefs);

  Future<void> register(String login, String password) async {
    prefs.setProfile(login, password);
    notifyListeners();
  }

  Future<ProfileOut?> logIn(String login, String password) async {
    ProfileOut? profile = await prefs.getProfile(login);
    String gotPasswordHash = encryptPassword(password);
    if (profile != null && gotPasswordHash == profile.passwordHash) {
      return profile;
    } else {
      return null;
    }
  }

  Future<void> load(String login) async {
    ProfileOut? profile = await prefs.getProfile(login);
    if (profile != null) {
      _profile = profile;
    }
    notifyListeners();
  }

}
