import 'package:flutter/material.dart';

class CardHome extends StatefulWidget {
  IconData icon;
  String textToApply;
  Widget route;

  CardHome(this.icon, this.textToApply, this.route);

  @override
  _CardHomeState createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: IconButton(
            icon: Icon(
              widget.icon,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    widget.route),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
          child: Text(
            "${widget.textToApply}",
            style: TextStyle(fontSize: 15),
          ),
        )
      ]),
    );
  }
}
