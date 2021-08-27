import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:madera_mobile/classes/Clients.dart';

class Maps extends StatefulWidget {
  Client client;
  Maps({required this.client});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Maps> {
  List<Location> locations = [];
  String err = "";

  void initState() {
    locationFromAddress("${widget.client.address}, ${widget.client.city}").then(
        (List<Location> locs) {
      setState(() {
        this.locations = locs;
      });
    }, onError: (Exception) {
      setState(() {
        this.err = "Une erreur est survenue lors du chargement de la carte.";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (err != "") {
      return Padding(
        padding: EdgeInsets.all(50),
        child: Text(
          "Une erreur est survenue lors du chargement de la carte.",
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (locations.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      height: 650,
      child: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(
              this.locations[0].latitude, this.locations[0].longitude),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/madera76/cksoq0mxh8t8217k0zkia6jgs/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFkZXJhNzYiLCJhIjoiY2tzb2sxcHR2MG50YTJybzY4OWx0dW1vbSJ9.Isdw-ATwUCPMHlU7mck9rw",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoibWFkZXJhNzYiLCJhIjoiY2tzb2sxcHR2MG50YTJybzY4OWx0dW1vbSJ9.Isdw-ATwUCPMHlU7mck9rw',
                'id': 'mapbox.mapbox-streets-v8'
              }),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 30.0,
                height: 30.0,
                point: latLng.LatLng(
                    this.locations[0].latitude, this.locations[0].longitude),
                builder: (ctx) => Container(
                  child: CircleAvatar(radius: 2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
