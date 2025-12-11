import 'package:flutter/material.dart';

class StopWatchAnalog extends StatelessWidget {
  const StopWatchAnalog({super.key, required this.elapsed});
  final Duration elapsed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Clockhand(
          width: 4,
          height: 150,
        ),
      ],
    );
  }
}

class Clockhand extends StatelessWidget {
  const Clockhand({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
