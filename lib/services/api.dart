import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:madera_mobile/classes/Clients.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madera_mobile/classes/User.dart';

import '../globals.dart' as globals;

class API {
  final String API_URL = globals.apiUrl;

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

  Future<Map<String, dynamic>> sendImage(
      String route, XFile image, String idClient) async {
    Map<String, dynamic> result = {"code": 1, "body": ""};

    var formData = FormData.fromMap({
      'idClient': idClient,
      'image': MultipartFile.fromFileSync("./assets/imgs/default.jpg",
          filename: 'clientImage.jpg')
    });
    var response = await Dio().post('/info', data: formData);

    return response.data;
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

  Future<Map<String, dynamic>> ajoutcli(Client client) async {
    Map<String, dynamic> result = {"code": 1, "body": ""};

    Uri url = Uri.parse('$API_URL/client/create');
    var response = await http.post(url, body: client.toJson());

    if (response.statusCode == 200 || response.statusCode == 201) {
      result["code"] = 0;
      result["body"] = jsonDecode(response.body);
    } else {
      result["code"] = 1;
      result["body"] = "error";
    }
    print(response.body);
    print(client.toJson());
    return result;
  }
}
