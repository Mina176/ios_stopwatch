import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ios_stopwatch/stop_watch_text.dart';

class StopWatchBody extends StatefulWidget {
  const StopWatchBody({super.key});

  @override
  State<StopWatchBody> createState() => _StopWatchBodyState();
}

class _StopWatchBodyState extends State<StopWatchBody>
    with SingleTickerProviderStateMixin {
  Duration _elapsed = Duration.zero;
  late final Ticker _ticker;
  final isRunning = false;
  @override
  void initState() {
    _ticker = createTicker((elapsed) {
      setState(() {
        _elapsed = elapsed;
      });
    });
    _ticker.start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StopWatchText(
          elapsed: _elapsed,
        ),
        Row(
          children: [
            ControlButton(
              label: 'Reset',
              onTap: () {
                setState(() {
                  _ticker.stop();
                  _elapsed = Duration.zero;
                });
              },
              color: Colors.grey[800]!,
            ),
            Spacer(),
            ControlButton(
              label: _ticker.isActive ? 'Stop' : 'Start',
              onTap: () {
                setState(() {
                  if (_ticker.isActive) {
                    _ticker.stop();
                  } else {
                    _ticker.start();
                  }
                });
              },
              color: _ticker.isActive ? Colors.red : Colors.green,
            ),
          ],
        )
      ],
    );
  }
}

class ControlButton extends StatelessWidget {
  const ControlButton(
      {super.key,
      required this.label,
      required this.onTap,
      required this.color});
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
