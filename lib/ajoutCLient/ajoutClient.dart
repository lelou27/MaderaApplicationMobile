import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madera_mobile/classes/Clients.dart';
import 'package:madera_mobile/services/api.dart';

class AjoutClientPage extends StatefulWidget {
  @override
  _AjoutClientPageState createState() => _AjoutClientPageState();
}

class _AjoutClientPageState extends State<AjoutClientPage> {
  final _formKey = GlobalKey<FormState>();
  String _first_name = "";
  String _mail = "";
  String _address = "";
  String _postal_code = "";
  String _city = "";
  String _phone = "";
  String _country = "";

  String _errorLogin = "";
  bool _isHidden = true;

  void ajoutClient() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    API api = new API();
    Client client = new Client(
        id: "",
        first_name: _first_name,
        mail: _mail,
        address: _address,
        postal_code: _postal_code,
        city: _city,
        phone: _phone,
        country: _country);
    Map<String, dynamic> ajoutcli = await api.ajoutcli(client, context);

    setState(() {
      _errorLogin =
          ajoutcli["code"] == 1 ? "Erreur dans l'ajout du client." : "";
    });

    if (ajoutcli["code"] == 1) return;
    final snackBar = SnackBar(content: Text('Client ajouté'));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', ModalRoute.withName('/home'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                      hintText: 'Nom',
                      labelText: 'Nom *',
                    ),
                    onChanged: (value) => setState(() => _first_name = value),
                    validator: (String? value) {
                      return (value == null || value == "")
                          ? 'Veuillez saisir un nom.'
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.alternate_email),
                      hintText: 'Email',
                      labelText: 'Email *',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => setState(() => _mail = value),
                    validator: (String? value) {
                      return (value == null ||
                              value == "" ||
                              !value.contains("@") ||
                              !value.contains("."))
                          ? 'Veuillez saisir un email valide.'
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.ad_units),
                      hintText: 'Téléphone',
                      labelText: 'Téléphone *',
                    ),
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() => _phone = value),
                    validator: (String? value) {
                      return (value == null || value == "")
                          ? 'Veuillez saisir un téléphone.'
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.my_location),
                      hintText: 'Adresse',
                      labelText: 'Adresse *',
                    ),
                    onChanged: (value) => setState(() => _address = value),
                    validator: (String? value) {
                      return (value == null || value == "")
                          ? 'Veuillez saisir une adresse'
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.contact_mail),
                      hintText: 'CodePostal',
                      labelText: 'Code postal *',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() => _postal_code = value),
                    validator: (String? value) {
                      return (value == null || value == "")
                          ? 'Veuillez saisir un code postal.'
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.location_city),
                      hintText: 'Ville',
                      labelText: 'Ville *',
                    ),
                    onChanged: (value) => setState(() => _city = value),
                    validator: (String? value) {
                      return (value == null || value == "")
                          ? 'Veuillez saisir une ville.'
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.language),
                      hintText: 'Pays',
                      labelText: 'Pays *',
                    ),
                    onChanged: (value) => setState(() => _country = value),
                    validator: (String? value) {
                      return (value == null || value == "")
                          ? 'Veuillez saisir un pays.'
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
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: ajoutClient,
                    child: const Text('Ajouter'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
