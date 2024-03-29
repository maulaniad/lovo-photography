import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseClient {
  static const String apiUrl = "http://10.0.2.2:5000";

  final client = http.Client();

  Future<dynamic> get(String url) async {
    var endpoint = Uri.parse(apiUrl + url);
    var response = await client.get(endpoint);
    if (response.statusCode == 200) {
      return response.body;
    }

    return response.statusCode;
  }

  Future<dynamic> post(String url, Map<String, dynamic> formData, {Map<String, dynamic> json = const {}}) async {
    var endpoint = Uri.parse(apiUrl + url);
    http.Response response;
    
    if (formData.isEmpty) {
      response = await client.post(endpoint,  headers: {'Content-type': "application/json"},  body: jsonEncode(json));
    }
    else {
      response = await client.post(endpoint, body: formData);
    }

    if (response.statusCode == 200) {
      return response.body;
    }

    return response.statusCode;
  }

  Future<dynamic> put(String url, Map<String, dynamic> formData) async {
    var endpoint = Uri.parse(apiUrl + url);

    var response = await client.put(endpoint, body: formData);
    if (response.statusCode == 200) {
      return response.body;
    }

    return response.statusCode;
  }
}
