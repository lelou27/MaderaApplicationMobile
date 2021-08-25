import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madera_mobile/classes/Clients.dart';
import 'package:madera_mobile/components/ListDevis.dart';
import 'package:madera_mobile/page/DetailClient.dart';
import 'package:madera_mobile/services/api.dart';

class ListClient extends StatefulWidget {
  @override
  _ListClientState createState() => _ListClientState();
}

class _ListClientState extends State<ListClient> {
  List<Client> clients = [];

  Future<void> getClients() async {
    API api = new API();
    var response = await api.getRequest(route: '/client');

    List<Client> clients = Client.clientsList(response["body"]);

    if (mounted) {
      this.setState(() {
        this.clients = clients;
      });
    }
  }

  void initState() {
    getClients();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: clients.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.grey,
                  child: ListTile(
                    title: Text("Clients"),
                    trailing: Icon(Icons.add),
                    onTap: () =>
                        Navigator.of(context).pushNamed("/ajoutClient"),
                  )),
              Expanded(
                child: ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        clients[index].first_name,
                      ),
                      subtitle: Text(clients[index].mail),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ListDevis(client: clients[index])),
                        );
                        // Navigator.of(context).push()
                      },
                      trailing: IconButton(
                        icon: new Icon(Icons.info_outline),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailClient(clients[index])),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ]),
    );
  }
}
