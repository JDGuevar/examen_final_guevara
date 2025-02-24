import 'package:examen_final_guevara/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:examen_final_guevara/providers/login_provider.dart';
import 'package:provider/provider.dart';

// crea una pagina de login que es mostrara quan l'usuari no estigui logejat

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                loginProvider.loggedIn = true;
                loginProvider.saveLogIn('user', 'password');
                Navigator.of(context).pushNamed('/');
              },
              child: Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}