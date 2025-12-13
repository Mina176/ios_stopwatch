import 'package:flutter/material.dart';
import 'package:ios_stopwatch/methods.dart';

class LapsRecord extends StatelessWidget {
  const LapsRecord({
    super.key,
    required this.elapsed,
    required this.lapTimes,
    required this.currentLap,
  });

  final Duration elapsed;
  final List<Duration> lapTimes;
  final Duration currentLap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: elapsed == Duration.zero ? 0 : lapTimes.length + 1,
      itemBuilder: (context, index) {
        final duration =
            index == 0 ? currentLap : lapTimes[lapTimes.length - index];
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
    );
  }
}
