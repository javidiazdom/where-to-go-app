import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HttpGraphqlService {
  static Uri uri = Uri.parse("http://192.168.1.37:4040/graphql");
  static Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json'
  };

  static Future<Map<String, String>> authHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token');
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }

  static Future<http.Response> mutate(String query, String variables,
      {bool requireAuth = false}) async {
    try {
      var bodyEncoded = json.encode({'query': query, 'variables': variables});
      var requestHeaders = requireAuth ? await authHeaders() : headers;
      return await http.post(uri, headers: requestHeaders, body: bodyEncoded);
    } on SocketException catch (error) {
      throw error;
    }
  }

  static Future<http.Response> query(String query,
      {String variables, bool requireAuth = false}) async {
    var bodyEncoded =
        json.encode({'query': query, 'variables': variables ?? ""});
    var requestHeaders = requireAuth ? await authHeaders() : headers;
    return await http.post(uri, headers: requestHeaders, body: bodyEncoded);
  }
}
