import 'package:flutter/material.dart';

class AboutDeveloper extends StatelessWidget {
  const AboutDeveloper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("This App Developed by"),
        Text("Ahmed Gamal (BoGaDev)"),
        SizedBox(height: 30)
      ],
    );
  }
}
