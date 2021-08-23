import 'package:flutter/material.dart';
import 'package:madera_mobile/classes/User.dart';
import 'package:madera_mobile/services/api.dart';

import '../globals.dart' as globals;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
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
    Map<String, dynamic> auth = await api.auth(user);

    setState(() {
      _errorLogin = auth["code"] == 1
          ? "Les identifiants renseignés sont incorrects."
          : "";
    });

    if (auth["code"] == 1) return;

    user.access_token = auth["body"]["access_token"];
    user.role = auth["body"]["role"];

    globals.isLoggedIn = true;
    globals.globalUser = user;

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', ModalRoute.withName('/home'));
  }

  void togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                onChanged: (value) => setState(() => _identifiant = value),
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
                  icon: Icon(Icons.password),
                  hintText: 'Mot de passe',
                  labelText: 'Mot de passe *',
                  suffix: InkWell(
                    child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off),
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
    );
  }
}
