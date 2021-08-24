import 'package:flutter/material.dart';
import 'package:madera_mobile/ajoutCLient/ajoutClient.dart';
import 'package:madera_mobile/auth/login.dart';
import 'package:madera_mobile/components/ListClient.dart';
import 'package:madera_mobile/components/MaderaAppBar.dart';
import 'package:madera_mobile/page/Home.dart';

import 'globals.dart' as globals;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: globals.applicationName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => MyHomePage(),
        '/listClient': (context) => ListClient(),
        '/login': (context) => LoginPage(),
        '/ajoutClient': (context) => AjoutClientPage(),
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLogged = false;

  void initState() {
    super.initState();

    globals.isLogged().then((bool isLogged) {
      setState(() {
        _isLogged = isLogged;
      });
    });
  }

  void logout() {
    setState(() {
      _isLogged = !_isLogged;
    });

    globals.logout(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLogged) {
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: LoginPage(),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context),
        body: Center(
          child: HomePage(),
        ),
      ),
    );
  }
}
