import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailElement extends StatefulWidget {
  @override
  String data;
  String title;
  DetailElement({required this.title, required this.data});

  _DetailElementState createState() => _DetailElementState();
}

class _DetailElementState extends State<DetailElement> {


  @override
  Widget build(BuildContext context) {

    return
      Column(
          children: [
            Row(
                children: <Widget>[
                  Text(widget.title,style: TextStyle(height: 2,fontSize: 15, color: Colors.black38))
                ]
            ),
            Row(
                children: <Widget>[
                  Text(widget.data, style: TextStyle(height: 1.5,fontSize: 25))
                ]
            ),
          ]
      );
  }
}
