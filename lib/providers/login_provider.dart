import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool loggedIn = false;

  LoginProvider();

  Future<List<String>> logIn() async {
    final prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool('loggedIn') ?? false;
    String? user = '';
    String? password = '';
    if (loggedIn) {
      user = prefs.getString('user') ?? '';
      password = prefs.getString('password') ?? '';
    }

    List<String?> logIn = [user, password];
    notifyListeners();
    return logIn as Future<List<String>>;
  }

  saveLogIn(usuario, contrasenya) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', usuario);
    await prefs.setString('favoriteDrinks', contrasenya);
  }
}
