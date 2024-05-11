import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:iwish_flutter/widgets/loading_indicator.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Color? bgColor;
  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Blur(
            blur: 4,
            colorOpacity: 0,
            child: Container(color: const Color.fromRGBO(0, 0, 0, 0.5)),
          ),
        if (isLoading) const LoadingIndicator()
      ],
    );
  }
}
