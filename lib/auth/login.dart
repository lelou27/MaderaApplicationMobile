import 'package:flutter/material.dart';
import 'package:madera_mobile/classes/User.dart';
import 'package:madera_mobile/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart' as globals;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String _identifiant = "";
  String _password = "";

  String _errorLogin = "";
  bool _isHidden = true;

  void login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    API api = new API();
    User user = new User(username: _identifiant, password: _password);
    Map<String, dynamic> auth = await api.auth(user, context);

    setState(() {
      if (auth["code"] == 1 && auth["body"] == 'apierror') {
        _errorLogin = "Erreur de connexion avec le serveur d'authentification.";
      } else if (auth["code"] == 1 && auth["body"] == 'error') {
        _errorLogin = "Les identifiants renseignés sont incorrects.";
      }
    });

    if (auth["code"] == 1) return;

    user.access_token = auth["body"]["access_token"];
    user.role = auth["body"]["role"];

    globals.isLoggedIn = true;
    globals.globalUser = user;

    this.setLoginPreferences(user);
  }

  void setLoginPreferences(User user) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      prefs.setStringList("user",
          [user.username, user.access_token, user.role]).then((bool success) {
        if (success) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          setState(() {
            _errorLogin = "Impossible de mettre à jour le stockage local.";
          });
        }
      });
    });
  }

  void togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(45),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Identifiant',
                        labelText: 'Identifiant *',
                      ),
                      onChanged: (value) =>
                          setState(() => _identifiant = value),
                      validator: (String? value) {
                        return (value == null || value == "")
                            ? 'Veuillez saisir un identifiant.'
                            : null;
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'Mot de passe',
                        labelText: 'Mot de passe *',
                        suffix: InkWell(
                          child: Icon(_isHidden
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onTap: togglePasswordView,
                        ),
                      ),
                      obscureText: _isHidden,
                      onChanged: (value) => setState(() => _password = value),
                      validator: (String? value) {
                        return (value == null || value == "")
                            ? 'Veuillez saisir un mot de passe.'
                            : null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        _errorLogin != "" ? _errorLogin : "",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: login,
                      child: const Text('Se connecter'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
