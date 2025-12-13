import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ios_stopwatch/control_button.dart';
import 'package:ios_stopwatch/methods.dart';
import 'package:ios_stopwatch/stop_watch_analog.dart';
import 'package:ios_stopwatch/stop_watch_text.dart';

class StopWatchBody extends StatefulWidget {
  const StopWatchBody({super.key});

  @override
  State<StopWatchBody> createState() => _StopWatchBodyState();
}

class _StopWatchBodyState extends State<StopWatchBody>
    with SingleTickerProviderStateMixin {
  Duration _elapsed = Duration.zero;
  late final Ticker ticker;
  @override
  void initState() {
    ticker = createTicker((elapsed) {
      setState(() {
        _elapsed = elapsed;
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

  Duration get _currentLap =>
      _elapsed - lapTimes.fold(Duration.zero, (t, d) => t + d);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  children: [
                    Center(child: TextStopWatch(elapsed: _elapsed)),
                    AnalogStopWatch(elapsed: _elapsed),
                  ],
                ),
              ),
              Positioned(
                bottom: 48,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2,
                    (index) => Container(
                      margin: EdgeInsets.all(6),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                            currentPage == index ? Colors.white : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ControlButton(
                      label: ticker.isActive ? 'Lap' : 'Reset',
                      onTap: () {
                        setState(() {
                          if (ticker.isActive) {
                            lapTimes.add(_currentLap);
                          } else {
                            lapTimes.clear();
                            ticker.stop();
                            _elapsed = Duration.zero;
                          }
                        });
                      },
                      color: Colors.grey[800]!,
                    ),
                    ControlButton(
                      label: ticker.isActive ? 'Stop' : 'Start',
                      onTap: () {
                        setState(() {
                          if (ticker.isActive) {
                            ticker.stop();
                          } else {
                            ticker.start();
                          }
                        });
                      },
                      color: ticker.isActive ? Colors.red : Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _elapsed == Duration.zero ? 0 : lapTimes.length + 1,
            itemBuilder: (context, index) {
              final duration =
                  index == 0 ? _currentLap : lapTimes[lapTimes.length - index];
              final lapNumber = lapTimes.length - index + 1;

              Color color = Colors.white;
              if (lapTimes.length >= 2) {
                final fastest = lapTimes.reduce((a, b) => a < b ? a : b);
                final slowest = lapTimes.reduce((a, b) => a > b ? a : b);
                if (duration == fastest) {
                  color = Colors.green;
                } else if (duration == slowest) {
                  color = Colors.red;
                }
              }
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade800),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lap $lapNumber',
                      style: TextStyle(fontSize: 18, color: color),
                    ),
                    Text(
                      formatTime(duration),
                      style: TextStyle(fontSize: 18, color: color),
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
}
