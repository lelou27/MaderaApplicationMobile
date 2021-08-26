import 'package:flutter/material.dart';

import '../globals.dart' as globals;

AppBar getAppBar(context) {
  return AppBar(
    title: Center(
        child: Image.asset(
      "assets/imgs/logo.png",
      height: 55,
    )),
    actions: [
      globals.isLoggedIn
          ? IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.white,
              onPressed: () {
                globals.logout(context).then((value) {
                  Navigator.of(context).pushReplacementNamed('/login');
                });
              })
          : Padding(padding: EdgeInsets.zero)
    ],
  );
}
