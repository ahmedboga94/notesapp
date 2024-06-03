import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

customStatusBarAndNavigationBar() {
  const SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent);

  SystemChrome.setSystemUIOverlayStyle(overlayStyle);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
}
