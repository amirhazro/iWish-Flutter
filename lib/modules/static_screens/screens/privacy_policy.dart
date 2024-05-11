import 'package:flutter/material.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const id = "/PrivacyPolicyScreen";
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextWidget(
            text: "Privacy Policy",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    );
  }
}
