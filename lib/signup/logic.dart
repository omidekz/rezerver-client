import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:service_manager_client/utils/apis.dart' as apis;
import 'package:service_manager_client/logic.dart' show Logic;

class SignUpPageLogic extends Logic {
  final state = ValueNotifier<SignUpPageStates>(SignUpPageStates.pend);
  final fullnameCtrl = TextEditingController(),
      usernameCtrl = TextEditingController(),
      passwordCtrl = TextEditingController(),
      confirmPasswordCtrl = TextEditingController(),
      phoneCtrl = TextEditingController();
  final usernameREX = RegExp(r'^[a-z_]{3,}$'),
      nationalcodeREX = RegExp(r'^\d{10}$'),
      phoneREX = RegExp(r'^09[0-9]{9}$');
  String? fullnameErrMsg = '',
      usernameErrMsg = '',
      passwordErrMsg = '',
      confirmPasswordErrMsg = '',
      phoneErrMsg = '';

  SignUpPageLogic() {
    fullnameCtrl.addListener(() => reloadUIAfter(() {
          String fn = getFullname();
          fullnameErrMsg = fn.isNotEmpty &&
                  fn.split(RegExp(r'\s+')).length >= 2 &&
                  fn.length > 7
              ? null
              : 'نام را بطور کامل وارد نمایید';
        }));
    passwordCtrl.addListener(() => reloadUIAfter(() => passwordErrMsg =
        getPassword().length >= 6 ? null : 'رمز عبور باید بیش از ۶ حرف باشد'));
    confirmPasswordCtrl.addListener(() => reloadUIAfter(() =>
        confirmPasswordErrMsg = getConfirmPassword() == getPassword()
            ? null
            : 'رمز تکرار شده یکسان نمی‌باشد'));
    phoneCtrl.addListener(() => reloadUIAfter(() => phoneErrMsg =
        phoneREX.hasMatch(getPhone())
            ? null
            : 'شماره موبایل بدرستی وارد نشده است'));
  }

  Future<bool> signupPressed() async {
    reloadUIAfter(() => state.value = SignUpPageStates.clicked);
    if (hasError()) {
      reloadUIAfter(() => state.value = SignUpPageStates.pend);
      return false;
    }
    try {
      Uri url = Uri.http(apis.baseURL, apis.signup);
      http.Response response = await http.post(url,
          body: jsonEncode({
            'full_name': getFullname(),
            'username': getPhone(),
            'password': getPassword(),
          }),
          headers: {'Content-Type': 'application/json'});
      Map resp = jsonDecode(response.body);
      if (response.statusCode == 200) {
        reloadUIAfter(() => state.value = SignUpPageStates.succeed);
        return true;
      } else if (resp['code'] == 1) {
        reloadUIAfter(() {
          usernameErrMsg = 'نام کاربری تکراری است';
        });
      }
    } catch (e) {
      print(e);
    }
    reloadUIAfter(() => state.value = SignUpPageStates.pend);
    return false;
  }

  void enter() {}
  void tryagain() {
    state.value = SignUpPageStates.pend;
  }

  bool hasError() {
    return fullnameErrMsg != null ||
        phoneErrMsg != null ||
        confirmPasswordErrMsg != null;
  }

  String getPhone() => phoneCtrl.text;
  String getConfirmPassword() => confirmPasswordCtrl.text;
  String getFullname() => fullnameCtrl.text;
  String getPassword() => passwordCtrl.text;
}

enum SignUpPageStates {
  pend,
  clicked,
  succeed,
  fail,
}
