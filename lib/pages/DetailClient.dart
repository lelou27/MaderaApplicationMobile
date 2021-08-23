import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madera_mobile/classes/Clients.dart';
import 'package:madera_mobile/components/DetailElement.dart';

class SecondRoute extends StatelessWidget {
  final Client client;
  const SecondRoute(this.client);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Madera Mobile Application'),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.black12
        ),
        child: Center(
          child:
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(left: 0,top :5,right:0,bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      child: ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: "https://images.unsplash.com/photo-1597466765990-64ad1c35dafc",
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(this.client.first_name ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),
                    ),
                    Center(
                      child: Text(this.client.mail ,style: TextStyle(height: 2,fontSize: 20, color: Colors.black38)),
                    ),
                    Center(
                      child: Text(this.client.phone ,style: TextStyle(height: 2,fontSize: 20, color: Colors.black38)),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    DetailElement(title: 'Adresse', data: this.client.address),
                    DetailElement(title: 'Code postal', data: this.client.postal_code),
                    DetailElement(title: 'Ville', data: this.client.city),
                    DetailElement(title: 'Pays', data: this.client.country),
                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
}