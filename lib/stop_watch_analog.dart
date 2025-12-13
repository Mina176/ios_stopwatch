import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ios_stopwatch/stop_watch_text.dart';

class AnalogStopWatch extends StatelessWidget {
  const AnalogStopWatch({super.key, required this.elapsed});
  final Duration elapsed;
  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.of(context).size.width / 2 - 68;
    return Stack(
      children: [
        for (int i = 0; i < 300; i++)
          Positioned(
            left: radius * 1.315,
            top: radius,
            child: CLockMarkers(
              seconds: i,
              radius: radius,
              markerLength: i % 5 == 0 ? 10 : 10,
              markerWidth: 2,
            ),
          ),
        for (int i = 5; i <= 60; i += 5)
          Positioned(
              left: radius * 1.315,
              top: radius,
              child: ClockMarkersText(value: i, maxValue: 60, radius: radius)),
        Positioned(
          left: radius * 1.315,
          top: radius,
          child: Clockhand(
              handThickness: 2,
              handLength: radius,
              color: Colors.orange,
              rotationZAngle: pi + (2 * pi / 60000) * elapsed.inMilliseconds),
        ),
        Positioned(
          left: radius,
          top: radius * 1.25,
          child: TextStopWatch(size: 24, elapsed: elapsed),
        ),
      ],
    );
  }
}

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
        ..translate(0.0, radius - height / 2, 0.0),
      child: Container(
        color: color,
        height: markerLength,
        width: markerWidth,
      ),
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
