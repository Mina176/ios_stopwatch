import 'package:flutter/material.dart';

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
