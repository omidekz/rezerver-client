import 'package:flutter/material.dart';
import 'package:service_manager_client/logic.dart';

class BottomNavigatorNotifier extends ValueNotifier<int> {
  BottomNavigatorNotifier(int value) : super(value);

  DashboardPages page() => value == 2
      ? DashboardPages.home
      : value == 1
          ? DashboardPages.store
          : DashboardPages.profile;
}

class DashboardLogic extends Logic {
  final bottomIndex = BottomNavigatorNotifier(2);
  void loadPage(int value) async {
    reloadUIAfter(() => bottomIndex.value = value);
  }
}

enum DashboardPages { home, profile, store }
