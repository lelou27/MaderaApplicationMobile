import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:madera_mobile/ajoutCLient/ajoutClient.dart';
import 'package:madera_mobile/auth/login.dart';
import 'package:madera_mobile/components/ListClient.dart';
import 'package:madera_mobile/components/MaderaAppBar.dart';
import 'package:madera_mobile/errors/NoConnexion.dart';
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
  bool _isLogged = true;
  bool _apiIsUp = true;

  void initState() {
    super.initState();

    checkApi();

    globals.isLogged().then((bool isLogged) {
      setState(() {
        _isLogged = isLogged;
      });
    });
  }

  Future<void> checkApi() async {
    try {
      var apiIsUp = await globals.api.getRequest(
        route: "/up",
        context: context,
      );

      if (apiIsUp['code'] == 0) {
        setState(() => _apiIsUp = true);
      } else {
        setState(() => _apiIsUp = false);
      }
    } catch (e) {
      setState(() => _apiIsUp = false);
    }
  }

  void logout() {
    setState(() {
      _isLogged = !_isLogged;
    });

    globals.logout(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!_apiIsUp) {
      return SafeArea(
        child: Scaffold(
          body: NoConnexion(),
        ),
      );
    }

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
        body: SingleChildScrollView(
          child: Center(
            child: HomePage(),
          ),
        ),
      ),
    );
  }
}
