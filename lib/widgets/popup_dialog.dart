import 'package:flutter/material.dart';

class PopupDialog extends StatelessWidget {
  const PopupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text("Please select image.")],
      ),
    );
  }
}
