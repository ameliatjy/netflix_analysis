import 'dart:convert';
import 'package:http/http.dart';

class HttpService {
  static const String uri = "http://localhost:8000";

  static Future<dynamic> getAllActorsData() async {
    Response res = await get(Uri.parse('$uri/actors_analysis'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}