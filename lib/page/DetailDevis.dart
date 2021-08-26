import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madera_mobile/classes/Clients.dart';
import 'package:madera_mobile/classes/Devis.dart';
import 'package:madera_mobile/classes/Module.dart';
import 'package:madera_mobile/components/DetailElement.dart';
import 'package:madera_mobile/components/MaderaAppBar.dart';
import 'package:madera_mobile/services/api.dart';

class DetailDevis extends StatefulWidget {
  final Devis devis;
  DetailDevis(this.devis);
  @override
  _DetailDevisState createState() => _DetailDevisState();
}

class _DetailDevisState extends State<DetailDevis> {
  String clientName = "";
  Map listModule = Map();
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
    Module module = Module.module(response["body"]);
    if (mounted) {
      this.setState(() {
        this.listModule[module] = value;
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

    map.forEach((key, value) {
      getModule(key, value);
    });
    getClient(widget.devis.client);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context),
        backgroundColor: Color(0xffE5E5E5),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  margin: EdgeInsets.only(
                    left: 7,
                    right: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 10.0, // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 20),
                          child: Column(
                            children: [
                              DetailElement(
                                  title: 'Nom du projet',
                                  data: widget.devis.nomProjet),
                              DetailElement(
                                  title: 'Date du devis',
                                  data: widget.devis.dateDevis),
                              DetailElement(
                                  title: 'Nom du Client', data: clientName),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  "Liste Modules",
                  style: TextStyle(height: 2, fontSize: 20),
                ),
                Expanded(child: _buildList()),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: listModule.length,
      itemBuilder: (context, index) {
        Module key = listModule.keys.elementAt(index);
        return Card(
            elevation: 10,
            margin: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: ListTile(
                title: Text(key.nomModule),
                subtitle: Text("${listModule[key].toString()} exemplaire")));
      },
    );
  }
}
