import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CheckSystemTheme {
  static Brightness brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  static bool isDarkMode = brightness == Brightness.dark;
}
