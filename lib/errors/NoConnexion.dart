import 'package:flutter/material.dart';

class NoConnexion extends StatefulWidget {
  @override
  _NoConnexionState createState() => _NoConnexionState();
}

class _NoConnexionState extends State<NoConnexion> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        "Erreur de connexion",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Nous sommes désolés, une erreur s'est produite.",
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Nous n'arrivons pas à vous connecter à nos serveurs. \n\nVeuillez redémarrer l'application.",
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Image.asset(
            "./assets/imgs/logo.png",
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
