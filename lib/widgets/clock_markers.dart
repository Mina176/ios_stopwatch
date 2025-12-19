import 'dart:math';

import 'package:flutter/material.dart';

class CLockMarkers extends StatelessWidget {
  const CLockMarkers(
      {super.key,
      required this.seconds,
      required this.radius,
      required this.markerLength,
      required this.markerWidth});
  final int seconds;
  final double radius;
  final double markerLength;
  final double markerWidth;

  @override
  Widget build(BuildContext context) {
    final color = seconds % 5 == 0 ? Colors.white : Colors.grey[700];
    const width = 5.0;
    const height = 5;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translate(-width / 2, -height / 2, 0.0)
        ..rotateZ(2 * pi * (seconds / 60))
        ..translate(
            0.0,
            seconds % 5 == 0 ? radius - height : radius - markerLength / 2,
            0.0),
      child: Container(
        color: color,
        height: markerLength,
        width: markerWidth,
      ),
    );
  }
}
