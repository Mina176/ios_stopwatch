String twoDigits(int n) => n.toString().padLeft(2, '0');
String formatTime(Duration elapsed) {
  final hours = twoDigits(elapsed.inHours.remainder(60));
  final minutes = twoDigits(elapsed.inMinutes.remainder(60));
  final seconds = twoDigits(elapsed.inSeconds.remainder(60));
  final milliseconds =
      (elapsed.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0');
  return hours == '00'
      ? '$minutes:$seconds.$milliseconds'
      : '$hours:$minutes:$seconds.$milliseconds';
}
