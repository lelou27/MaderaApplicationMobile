import 'package:http/http.dart' as http;

class API {
  final String API_URL = "http://10.0.2.2:5000";

  Future<void> getRequest({required String route}) async {
    Uri url = Uri.parse('$API_URL$route');
    print('$API_URL$route');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
