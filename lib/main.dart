import 'package:flutter/material.dart';
import 'package:madera_mobile/ajoutCLient/ajoutClient.dart';
import 'package:madera_mobile/auth/login.dart';
import 'package:madera_mobile/components/ListClient.dart';

import 'globals.dart' as globals;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Madera Mobile Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => MyHomePage(title: 'Madera Mobile Application'),
        '/login': (context) => LoginPage(),
        '/ajoutClient': (context) => AjoutClientPage(),
      },
      // home: AjoutClientPage(),
      home: MyHomePage(title: 'Madera Mobile Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            _isLogged
                ? IconButton(
                    icon: const Icon(Icons.logout),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        _isLogged = !_isLogged;
                      });

                      globals.logout();
                    },
                  )
                : Padding(padding: EdgeInsets.zero)
          ],
        ),
        body: Center(
          child: ListClient(),
        ),
      ),
    );
  }
}
