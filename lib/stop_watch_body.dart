import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ios_stopwatch/control_buttons.dart';
import 'package:ios_stopwatch/laps_record.dart';
import 'package:ios_stopwatch/slider_index.dart';
import 'package:ios_stopwatch/widgets/stop_watches_slider.dart';

class StopWatchBody extends StatefulWidget {
  const StopWatchBody({super.key});

  @override
  State<StopWatchBody> createState() => _StopWatchBodyState();
}

class _StopWatchBodyState extends State<StopWatchBody>
    with SingleTickerProviderStateMixin {
  Duration previousElapsed = Duration.zero;
  Duration elapsed = Duration.zero;
  late final Ticker ticker;
  @override
  void initState() {
    ticker = createTicker((elapsed) {
      setState(() {
        this.elapsed = previousElapsed + elapsed;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  List<Duration> lapTimes = [];
  int currentPage = 0;

  Duration get currentLap =>
      elapsed - lapTimes.fold(Duration.zero, (t, d) => t + d);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            StopWatchesSlider(
                elapsed: elapsed,
                currentLap: currentLap,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                }),
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: SliderIndex(currentPage: currentPage),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ControlButtons(
                ticker: ticker,
                elapsed: elapsed,
                currentLap: currentLap,
                lapTimes: lapTimes,
                onReset: () {
                  setState(() {
                    elapsed = Duration.zero;
                    previousElapsed = Duration.zero;
                  });
                },
                onStop: () {
                  setState(() {
                    previousElapsed = elapsed;
                  });
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: LapsRecord(
              elapsed: elapsed, lapTimes: lapTimes, currentLap: currentLap),
        ),
      ],
    );
  }
}
