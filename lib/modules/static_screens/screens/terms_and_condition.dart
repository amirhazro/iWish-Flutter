import 'package:flutter/material.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class TermsAndConditionScreen extends StatelessWidget {
  static const id = "/TermsAndConditionScreen";
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextWidget(
            text: "Terms and Condition",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    );
  }
}
