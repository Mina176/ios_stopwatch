import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ios_stopwatch/widgets/control_button.dart';

class ControlButtons extends StatefulWidget {
  const ControlButtons({
    super.key,
    required this.ticker,
    required this.elapsed,
    required this.currentLap,
    required this.lapTimes,
    this.onReset,
  });

  final Ticker ticker;
  final Duration elapsed;
  final Duration currentLap;
  final List<Duration> lapTimes;
  final VoidCallback? onReset;

  @override
  State<ControlButtons> createState() => _ControlButtonsState();
}

class _ControlButtonsState extends State<ControlButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ControlButton(
          label: widget.ticker.isActive ? 'Lap' : 'Reset',
          onTap: () {
            setState(() {
              if (widget.ticker.isActive) {
                widget.lapTimes.add(widget.currentLap);
              } else {
                widget.lapTimes.clear();
                widget.ticker.stop();
                widget.onReset?.call();
              }
            });
          },
          color: Colors.grey[800]!,
        ),
        ControlButton(
          label: widget.ticker.isActive ? 'Stop' : 'Start',
          onTap: () {
            setState(() {
              if (widget.ticker.isActive) {
                widget.ticker.stop();
              } else {
                widget.ticker.start();
              }
            });
          },
          color: widget.ticker.isActive ? Colors.red : Colors.green,
        ),
      ],
    );
  }
}
