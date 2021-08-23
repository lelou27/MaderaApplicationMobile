import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madera_mobile/services/api.dart';

class ListClient extends StatelessWidget {
  List<String> items = List<String>.generate(10000, (i) => "Item $i");

  Future<void> getClients() async {
    API api = new API();
    var response = await api.getRequest(route: '/client');
  }

  @override
  Widget build(BuildContext context) {
    getClients();

    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () {
              SnackBar snackBar = SnackBar(
                  content: Text("Tapped : ${index + 1}")
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            trailing: Icon(Icons.info_outline),
          );
        },
      ),
    );
  }

}