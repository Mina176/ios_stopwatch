import 'package:flutter/material.dart';
import 'package:ios_stopwatch/stop_watch_body.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: Padding(
        padding: const EdgeInsets.all(16),
        child: StopWatch(),
      ),
    );
  }
}

class StopWatch extends StatelessWidget {
  const StopWatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StopWatchBody(),
    );
  }
}
