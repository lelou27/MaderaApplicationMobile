import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madera_mobile/classes/Clients.dart';
import 'package:madera_mobile/classes/Devis.dart';
import 'package:madera_mobile/components/MaderaAppBar.dart';
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
    var response =
        await api.getRequest(route: '/devis/all${id == "" ? 'Cs' : '/${id}'}');

    List<Devis> devis = Devis.devisList(response["body"]);

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
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context),
        backgroundColor: Color(0xffE5E5E5),
        body: devis.length == 0
            ? Center(
                child: Text("Pas de devis"),
              )
            : Column(children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: devis.length,
                    itemBuilder: (context, index) {
                      return Card(
                          elevation: 10,
                          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                          child: ListTile(
                            title: Text(
                              devis[index].nomProjet,
                            ),
                            subtitle: Text(devis[index].dateDevis),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailDevis(devis[index])),
                              );
                            },
                          ));
                    },
                  ),
                ),
              ]),
      ),
    );
  }
}
