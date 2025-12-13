import 'package:flutter/material.dart';
import 'package:ios_stopwatch/stop_watch_analog.dart';
import 'package:ios_stopwatch/widgets/stop_watch_text.dart';

class StopWatchesSlider extends StatelessWidget {
  const StopWatchesSlider({
    super.key,
    required this.elapsed,
    required this.currentLap,
    this.onPageChanged,
  });

  final Duration elapsed;
  final Duration currentLap;
  final void Function(int)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageView(
        physics: BouncingScrollPhysics(),
        onPageChanged: onPageChanged,
        children: [
          Center(child: TextStopWatch(elapsed: elapsed)),
          AnalogStopWatch(
            elapsed: elapsed,
            currentLap: currentLap,
          ),
        ],
      ),
    );
  }
}