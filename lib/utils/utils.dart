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

  Future<String> getCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cityKey) ?? 'Караганда';
  }

  Future<void> setLoggedInLogin(String login) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loggedInProfileLogin, login);
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

  String _city = 'Караганда';
  String get city => _city;

  WeatherController(this.prefs);

  Future<void> load() async {
    _city = await prefs.getCity();
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