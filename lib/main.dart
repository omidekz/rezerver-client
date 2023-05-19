import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:service_manager_client/dashboard/index.dart';
import 'package:service_manager_client/dashboard/logic.dart';
import 'package:service_manager_client/login/index.dart';
import 'package:service_manager_client/login/logic.dart';
import 'package:service_manager_client/signup/index.dart';
import 'package:service_manager_client/signup/logic.dart';

void getit() {
  GetIt.I.registerLazySingleton<SignUpPageLogic>(() => SignUpPageLogic());
  GetIt.I.registerLazySingleton<DashboardLogic>(() => DashboardLogic());
  GetIt.I.registerLazySingleton<LoginLogic>(() => LoginLogic());
}

void main() {
  getit();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Colors.lightBlue,
          secondary: Colors.orange.shade700,
        ),
      ),
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
      initialRoute: '/signup',
    ),
  );
}
