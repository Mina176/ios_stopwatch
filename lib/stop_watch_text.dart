import 'package:flutter/material.dart';

class StopWatchText extends StatelessWidget {
  const StopWatchText({
    super.key,
    required this.elapsed,
  });
  final Duration elapsed;

  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String formattedTime() {
    final minutes = twoDigits(elapsed.inMinutes.remainder(60));
    final seconds = twoDigits(elapsed.inSeconds.remainder(60));
    final milliseconds =
        (elapsed.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds.$milliseconds';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedTime(),
      style: TextStyle(
        fontSize: 80,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }
}
