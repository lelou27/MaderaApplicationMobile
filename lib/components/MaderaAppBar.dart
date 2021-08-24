import 'package:flutter/material.dart';

import '../globals.dart' as globals;

AppBar getAppBar(context) {
  return AppBar(
    title: Text(globals.applicationName),
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
