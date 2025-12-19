import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ios_stopwatch/widgets/clock_hand.dart';
import 'package:ios_stopwatch/widgets/clock_markers.dart';
import 'package:ios_stopwatch/widgets/clock_markers_text.dart';
import 'package:ios_stopwatch/widgets/stop_watch_text.dart';

class AnalogStopWatch extends StatelessWidget {
  const AnalogStopWatch(
      {super.key, required this.elapsed, required this.currentLap});
  final Duration elapsed;
  final Duration currentLap;
  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.of(context).size.width / 2 - 68;
    return Stack(
      children: [
        for (int i = 0; i < 60; i++)
          Positioned(
            left: radius * 1.315,
            top: radius,
            child: CLockMarkers(
              seconds: i,
              radius: radius,
              markerLength: i % 5 == 0 ? 10 : 8,
              markerWidth: 2,
            ),
          ),
        for (int i = 5; i <= 60; i += 5)
          Positioned(
              left: radius * 1.315,
              top: radius,
              child: ClockMarkersText(value: i, maxValue: 60, radius: radius)),
        Positioned(
          left: radius * 1.305,
          top: radius,
          child: Clockhand(
              handThickness: 2,
              handLength: radius,
              color: Colors.blue,
              rotationZAngle:
                  pi + (2 * pi / 60000) * currentLap.inMilliseconds),
        ),
        Positioned(
          left: radius * 1.305,
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
          child: TextStopWatch(
            size: 24,
            elapsed: elapsed,
          ),
        ),
      ],
    );
  }
}
