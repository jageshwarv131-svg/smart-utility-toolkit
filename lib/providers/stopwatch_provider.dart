import 'package:flutter/material.dart';

class StopwatchProvider extends ChangeNotifier {
  late Stopwatch _stopwatch;
  String _time = '00:00:00';
  List<String> _laps = [];

  String get time => _time;
  List<String> get laps => _laps;
  bool get isRunning => _stopwatch.isRunning;

  StopwatchProvider() {
    _stopwatch = Stopwatch();
  }

  void start() {
    _stopwatch.start();
    _updateTime();
    notifyListeners();
  }

  void pause() {
    _stopwatch.stop();
    notifyListeners();
  }

  void resume() {
    _stopwatch.start();
    _updateTime();
    notifyListeners();
  }

  void reset() {
    _stopwatch.reset();
    _time = '00:00:00';
    _laps = [];
    notifyListeners();
  }

  void addLap() {
    _laps.add(_time);
    notifyListeners();
  }

  void _updateTime() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_stopwatch.isRunning) {
        _formatTime();
        notifyListeners();
        _updateTime();
      }
    });
  }

  void _formatTime() {
    final milliseconds = _stopwatch.elapsedMilliseconds;
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    _time = '$hoursStr:$minutesStr:$secondsStr';
  }
}
