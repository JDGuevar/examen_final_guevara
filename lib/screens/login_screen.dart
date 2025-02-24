import 'package:flutter/material.dart';
import 'package:examen_final_guevara/providers/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
   @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  GlobalKey<FormState> _key = GlobalKey();
  String? _usuari;
  String? _passwd;
  String missatge = '';
  bool _saveUser = false;

  late var loginProvider;

  initState() async{
    super.initState();
    final loginProvider = Provider.of<LoginProvider>(context);
    List<String> logIn = await loginProvider.logIn();
    _usuari = logIn[0];
    _passwd = logIn[1];
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    //Descomentar las siguientes lineas para generar un efecto de "respiracion"

    //Honestamente esto lo saqué de internet (jdgr)

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  dispose() {
    // Es important SEMPRE realitzar el dispose del controller.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              child: AnimatedLogo(animation: animation),
            ),
            if (_usuari != null && _passwd != null)_loginRegisterRequest() else loginOrRegisterForm(),
            SizedBox(height: 100),
            loginButton()
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        loginProvider.saveLogIn(_usuari, _passwd);
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: Colors.blue[800],
      selectedColor: Colors.white,
      fillColor: Colors.blue[200],
      color: Colors.blue[400],
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 120.0,
      ),
      isSelected: loginProvider.selectedEvent,
      children: events,
    );
  }

  Widget loginOrRegisterForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Inicia sessió' ),
        Container(
          width: 300.0,
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: '',
                  validator: (text) {
                    if (text!.length == 0) {
                      return "Usuari es obligatori";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Escrigui el seu usuari',
                    labelText: 'Usuari',
                    counterText: '',
                    icon:
                        Icon(Icons.person, size: 32.0, color: Colors.blue[800]),
                  ),
                  onSaved: (text) => _usuari = text,
                ),
                TextFormField(
                  initialValue: '',
                  validator: (text) {
                    if (text!.length == 0) {
                      return "Contrasenya és obligatori";
                    } else if (text.length <= 5) {
                      return "Contrasenya mínim de 5 caràcters";
                    } 
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Escrigui la contrasenya',
                    labelText: 'Contrasenya',
                    counterText: '',
                    icon: Icon(Icons.lock, size: 32.0, color: Colors.blue[800]),
                  ),
                  onSaved: (text) => _passwd = text,
                ),
                loginProvider.loggedIn
                    ? CheckboxListTile(
                        value: _saveUser,
                        onChanged: (value) {
                          _saveUser = value!;
                          loginProvider.loggedIn = value;
                          setState(() {});
                        },
                        title: Text('Recorda\'m'),
                        controlAffinity: ListTileControlAffinity.leading,
                      )
                    : SizedBox(height: 56),
                IconButton(
                  onPressed: () => _loginRegisterRequest(),
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 42.0,
                    color: Colors.blue[800],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _loginRegisterRequest(){
    Navigator.pushNamed(context, '/home');
  }
}

class AnimatedLogo extends AnimatedWidget {
  // Maneja los Tween estáticos debido a que estos no cambian.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = Tween<double>(begin: 0.0, end: 100.0);

  AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: _sizeTween.evaluate(animation), // Aumenta la altura
        width: _sizeTween.evaluate(animation), // Aumenta el ancho
        child: FlutterLogo(),
      ),
    );
  }
}

const List<Widget> events = <Widget>[
  Text('Inicia sessió'),
];