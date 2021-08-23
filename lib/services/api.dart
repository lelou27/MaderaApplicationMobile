import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:madera_mobile/classes/User.dart';

class API {
  final String API_URL = "http://10.0.2.2:5000";

  Future<Map<String, dynamic>> getRequest({required String route}) async {
    Map<String, dynamic> result = {"code": 1, "body": ""};

    Uri url = Uri.parse('$API_URL$route');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      result["code"] = 0;
      result["body"] = jsonDecode(response.body);
    } else {
      result["code"] = 1;
      result["body"] = "error";
    }

    return result;
  }

  Future<Map<String, dynamic>> auth(User user) async {
    Map<String, dynamic> result = {"code": 1, "body": ""};

    Uri url = Uri.parse('$API_URL/auth/login');
    var response = await http.post(url, body: user.toJson());

    if (response.statusCode == 200 || response.statusCode == 201) {
      result["code"] = 0;
      result["body"] = jsonDecode(response.body);
    } else {
      result["code"] = 1;
      result["body"] = "error";
    }

    return result;
  }
}
