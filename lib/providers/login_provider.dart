import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginProvider extends ChangeNotifier {
  bool loggedIn = false;

  LoginProvider() {
    _logIn();
  }

  Future<List<String>> _logIn() async {
    final prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool('loggedIn') ?? false;
    String? user = '';
    String? password = '';
    if (loggedIn) {
      user = prefs.getString('user');
      password = prefs.getString('password');
    }

    List<String?> logIn = [user, password];
    notifyListeners();
    return logIn as Future<List<String>>;
  }

  _saveLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteDrinkIds', _favoriteDrinkIds.toList());
    await prefs.setString('favoriteDrinks', json.encode(_favoriteDrinks));
  }
}
