import 'package:flutter/material.dart';
import 'package:ios_stopwatch/methods.dart';

class TextStopWatch extends StatelessWidget {
  const TextStopWatch({
    super.key,
    required this.elapsed,
    this.size = 80,
  });
  final Duration elapsed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      formatTime(elapsed),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }
}
