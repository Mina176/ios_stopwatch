import 'package:flutter/material.dart';

class TextStopWatch extends StatelessWidget {
  const TextStopWatch({
    super.key,
    required this.elapsed,
    this.size = 80,
  });
  final Duration elapsed;
  final double size;
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String formattedTime() {
    final hours = twoDigits(elapsed.inHours.remainder(60));
    final minutes = twoDigits(elapsed.inMinutes.remainder(60));
    final seconds = twoDigits(elapsed.inSeconds.remainder(60));
    final milliseconds =
        (elapsed.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0');
    return hours == '00'
        ? '$minutes:$seconds.$milliseconds'
        : '$hours:$minutes:$seconds.$milliseconds';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedTime(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }
}
