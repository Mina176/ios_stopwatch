import 'dart:math';

import 'package:flutter/material.dart';

class StopWatchAnalog extends StatelessWidget {
  const StopWatchAnalog({super.key, required this.elapsed});
  final Duration elapsed;

  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.of(context).size.width / 2 - 68;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.orange, width: 2),
          ),
        ),
        Positioned(
          left: radius * 1.35,
          top: radius,
          child: Clockhand(
            handThickness: 2,
            handLength: radius,
            color: Colors.orange,
            rotationZAngle: pi + (2 * pi / 6000) * elapsed.inMilliseconds,
          ),
        ),
      ],
    );
  }
}

class Clockhand extends StatelessWidget {
  const Clockhand({
    super.key,
    required this.handThickness,
    required this.handLength,
    required this.color,
    required this.rotationZAngle,
  });
  final double handThickness;
  final double handLength;
  final Color color;
  final double rotationZAngle;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..translate(-handThickness / 2, 0.0, 0.0)
        ..rotateZ(rotationZAngle),
      child: Container(
        width: handThickness,
        height: handLength,
        color: color,
      ),
    );
  }
}
