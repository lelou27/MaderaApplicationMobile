import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madera_mobile/classes/Clients.dart';
import 'package:madera_mobile/classes/Devis.dart';
import 'package:madera_mobile/classes/Module.dart';
import 'package:madera_mobile/components/DetailElement.dart';
import 'package:madera_mobile/services/api.dart';

class DetailDevis extends StatefulWidget {
  final Devis devis;
  DetailDevis(this.devis);
  @override
  _DetailDevisState createState() => _DetailDevisState();
}
class _DetailDevisState extends State<DetailDevis> {
  String clientName = "";
  Map test = Map();
  final ScrollController scrollController = ScrollController();

  Future<void> getClient(id) async {
    API api = new API();
    var response = await api.getRequest(route: '/client/${id}');
    Client clients = Client.client(response["body"]);
    if (mounted) {
      this.setState(() {
        this.clientName = clients.first_name;
      });
    }
  }

  Future<void> getModule(id, value) async {
    API api = new API();
    var response = await api.getRequest(route: '/module/${id}');
    Module clients = Module.module(response["body"]);
    if (mounted) {
      this.setState(() {
        this.test[clients] = value;
      });
    }
  }

  void initState() {
    var elements = widget.devis.modules;
    var map = Map();

    elements.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });
    print(map);
    map.forEach((key, value) {
      getModule(key, value);
    });
    getClient(widget.devis.client);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Madera Mobile Application'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            DetailElement(
                                title: 'Nom du projet',
                                data: widget.devis.nomProjet),
                            DetailElement(
                                title: 'Date du devis',
                                data: widget.devis.dateDevis),
                            DetailElement(title: 'Nom du Client',
                                data: clientName),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ),
          Expanded(
            child: _buildList(),
          )

        ],
      ),
    );
  }

  Widget _buildList() {
    return
      ListView.builder(
      itemCount: test.length,
      itemBuilder: (context,index){
        Module key = test.keys.elementAt(index);
        return ListTile(
          title: Text(key.nomModule),
            subtitle: Text("${test[key].toString()} exemplaire")
        );
      },
    );
  }
}