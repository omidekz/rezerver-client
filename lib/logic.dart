import 'package:flutter/material.dart';

class Logic {
  final signal = ValueNotifier<bool>(false);
  void reloadUI() {
    signal.value = !signal.value;
  }

  void reloadUIAfter(VoidCallback cb) {
    cb();
    reloadUI();
  }
}
