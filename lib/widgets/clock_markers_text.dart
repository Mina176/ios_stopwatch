import 'dart:math';

import 'package:flutter/material.dart';

class ClockMarkersText extends StatelessWidget {
  const ClockMarkersText({
    super.key,
    required this.value,
    required this.maxValue,
    required this.radius,
    this.fontSize = 24,
  });
  final int value;
  final int maxValue;
  final double radius;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    final width = 40.0;
    final height = 30.0;
    return Transform(
      transform: Matrix4.identity()
        ..translate(-width / 2, -height / 2, 0.0)
        ..rotateZ(pi + 2 * pi * (value / maxValue))
        ..translate(0.0, radius - 30, 0.0)
        ..rotateZ(pi - 2 * pi * (value / maxValue)),
      child: SizedBox(
        width: width,
        height: height,
        child: Text(
          style: TextStyle(color: Colors.white, fontSize: fontSize),
          '$value',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
