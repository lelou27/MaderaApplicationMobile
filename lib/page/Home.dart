import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madera_mobile/classes/Clients.dart';
import 'package:madera_mobile/components/CardHome.dart';
import 'package:madera_mobile/components/ListClient.dart';
import 'package:madera_mobile/components/ListDevis.dart';
import 'package:madera_mobile/globals.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Text(
                      "Bienvenue ${globalUser.username} ! 😊",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardHome(Icons.list, "Liste des clients", ListClient()),
                CardHome(Icons.list_alt, "Liste des devis", ListDevis(new Client(id: "", first_name: "first_name", mail: "mail", phone: "phone", address: "address", postal_code: "postal_code", city: "city", country: "country"))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardHome(Icons.list, "Liste des clients", ListClient()),
              CardHome(Icons.list, "Liste des clients", ListClient()),
            ],
          ),
        ],
      ),
    );
  }
}
