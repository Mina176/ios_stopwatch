import 'package:flutter/material.dart';
import 'package:ios_stopwatch/stop_watch_analog.dart';
import 'package:ios_stopwatch/stop_watch_text.dart';

class StopWatchesSlider extends StatefulWidget {
  const StopWatchesSlider({super.key, required this.elapsed});
  final Duration elapsed;

  @override
  State<StopWatchesSlider> createState() => _StopWatchesSliderState();
}

class _StopWatchesSliderState extends State<StopWatchesSlider> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: PageView(
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            children: [
              StopWatchText(elapsed: widget.elapsed),
              StopWatchAnalog(elapsed: widget.elapsed),
            ],
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              2,
              (index) => Container(
                margin: EdgeInsets.all(8),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentPage == index ? Colors.white : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            )),
      ],
    );
  }
}
