import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:service_manager_client/utils/apis.dart' as apis;
import 'package:service_manager_client/utils/pref_db.dart';

Future<http.Response> _post(
    Uri uri, Object? body, Map<String, String>? headers) async {
  return await http.post(uri, body: body, headers: headers);
}

Future<Map?> post(String url, Map? body) async {
  http.Response resp = await _post(Uri.parse(apis.baseURL + url), body, {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPreferences.getString('jwt')}',
  });
  if (resp.statusCode >= 500) {
    return null;
  }
  return jsonDecode(resp.body);
}
