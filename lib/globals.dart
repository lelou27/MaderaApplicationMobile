library globals;

import 'package:madera_mobile/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'classes/User.dart';

bool isLoggedIn = false;
User globalUser = setAnonymous();
API api = new API();
String applicationName = "Madera Mobile Application";

User setAnonymous() {
  return new User(username: "anonymous", password: "anonymous");
}

Future<bool> isLogged() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? userPrefs = prefs.getStringList("user");

  if (userPrefs != null && userPrefs.length != 0) {
    globalUser = new User(username: userPrefs[0], password: "");
    isLoggedIn = true;
  }

  return isLoggedIn;
}

Future<void> logout(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList("user", []);
  globalUser = setAnonymous();
}
