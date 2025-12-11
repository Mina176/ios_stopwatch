import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ios_stopwatch/control_button.dart';
import 'package:ios_stopwatch/stop_watches_slider.dart';

class StopWatchBody extends StatefulWidget {
  const StopWatchBody({super.key});

  @override
  State<StopWatchBody> createState() => _StopWatchBodyState();
}

class _StopWatchBodyState extends State<StopWatchBody>
    with SingleTickerProviderStateMixin {
  Duration _baseElapsed = Duration.zero;
  Duration elapsed = Duration.zero;
  late final Ticker _ticker;
  @override
  void initState() {
    _ticker = createTicker((elapsed) {
      setState(() {
        this.elapsed = _baseElapsed + elapsed;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  List<Duration> lapTimes = [];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              StopWatchesSlider(
                elapsed: elapsed,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ControlButton(
                    label: _ticker.isActive ? 'Lap' : 'Reset',
                    onTap: () {
                      setState(() {
                        if (_ticker.isActive) {
                          lapTimes.add(elapsed);
                        } else {
                          lapTimes.clear();
                          _ticker.stop();
                          elapsed = Duration.zero;
                          _baseElapsed = Duration.zero;
                        }
                      });
                    },
                    color: Colors.grey[800]!,
                  ),
                  ControlButton(
                    label: _ticker.isActive ? 'Stop' : 'Start',
                    onTap: () {
                      setState(() {
                        if (_ticker.isActive) {
                          _ticker.stop();
                          _baseElapsed = elapsed;
                        } else {
                          _ticker.start();
                          lapTimes.add(elapsed);
                        }
                      });
                    },
                    color: _ticker.isActive ? Colors.red : Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: lapTimes.length,
            itemBuilder: (context, index) {
              final reversedIndex = lapTimes.length - 1 - index;
              final lapTime = reversedIndex == 0
                  ? lapTimes[reversedIndex]
                  : lapTimes[reversedIndex] - lapTimes[reversedIndex - 1];
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade800),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lap ${reversedIndex + 1}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      formatTime(lapTime),
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliseconds =
        (duration.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds.$milliseconds';
  }
}
