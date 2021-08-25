import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madera_mobile/classes/Clients.dart';
import 'package:madera_mobile/classes/Devis.dart';
import 'package:madera_mobile/page/DetailClient.dart';
import 'package:madera_mobile/page/DetailDevis.dart';
import 'package:madera_mobile/services/api.dart';

class ListDevis extends StatefulWidget {
Client client;
  ListDevis(this.client);

  @override
  _ListDevisState createState() => _ListDevisState();
}

class _ListDevisState extends State<ListDevis> {
  List<Devis> devis = [];

  Future<void> getDevis(id) async {
    API api = new API();
    var response = await api.getRequest(route: '/devis/all${id == ""? '' : '/${id}'}');
    //print(response["body"][0]);
    List<Devis> devis = Devis.devisList(response["body"]);
    //print(devis[0].modules);
    if (mounted) {
      this.setState(() {
        this.devis = devis;
      });
    }
  }
  void initState() {
    getDevis(widget.client.id);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(appBar: AppBar(),
      body: devis.length == 0
          ? Center(
        child: Text("Pas de devis"),
      )
          : Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: devis.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  devis[index].nomProjet,
                ),
                subtitle: Text(devis[index].dateDevis),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailDevis(devis[index])
                    ),
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
