library globals;

import 'classes/User.dart';

bool isLoggedIn = false;
User globalUser = new User(username: "anonymous", password: "anonymous");
