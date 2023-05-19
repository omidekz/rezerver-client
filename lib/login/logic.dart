import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:service_manager_client/logic.dart';
import 'package:http/http.dart' as http;
import 'package:service_manager_client/utils/apis.dart' as APIS;
import 'package:service_manager_client/utils/pref_db.dart';

enum UserType { guest }

class LoginLogic extends Logic {
  TextEditingController usernameCtrl = TextEditingController(),
      passwordCtrl = TextEditingController();
  String? usernameErrMsg = '', passwordErrMsg = '';
  String userType = '';
  final hasErr = ValueNotifier<bool>(false);

  Future<bool> loginPressed() async {
    http.Response resp = await http.post(
      Uri.parse(APIS.login),
      body: jsonEncode(
        {'username': getUsername(), 'password': getPassword()},
      ),
      headers: {'Content-Type': 'application/json'},
    );
    if (resp.statusCode == 200) {
      hasErr.value = false;
      Map<String, String> respBody = jsonDecode(resp.body);
      SharedPreferences.setJWT(respBody);
    } else {
      hasErr.value = true;
    }
    return resp.statusCode == 200;
  }

  String getUsername() => usernameCtrl.text;
  String getPassword() => passwordCtrl.text;
}
