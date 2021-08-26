import 'package:flutter/material.dart';
import 'package:madera_mobile/auth/login.dart';
import 'package:madera_mobile/page/Home.dart';

import '../globals.dart' as globals;

AppBar getAppBar(context) {
  return AppBar(
    title: Center(
        child: Material(
          color: Colors.blue,
          child: InkWell(
            onTap: (){
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                "assets/imgs/logo.png",
                height: 55,
              )),
          ),
        )


        ),
    actions: [
      globals.isLoggedIn
          ? IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.white,
              onPressed: () {
                globals.logout(context).then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                });
              })
          : Padding(padding: EdgeInsets.zero)
    ],
  );
}
