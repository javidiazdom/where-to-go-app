import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpGraphqlService {
  static Uri uri = Uri.parse("http://192.168.1.37:4040/graphql");
  static Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json'
  };

  static Future<http.Response> mutate(String query, String variables) async {
    var bodyEncoded = json.encode({'query': query, 'variables': variables});
    return await http.post(uri, headers: headers, body: bodyEncoded);
  }

  static Future<http.Response> query(String query, [String variables]) async {
    var bodyEncoded = json.encode({'query': query, 'variables': variables});
    return await http.post(uri, headers: headers, body: bodyEncoded);
  }
}
