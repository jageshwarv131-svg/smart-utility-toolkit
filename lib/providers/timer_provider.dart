import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  late Duration _duration;
  late Duration _initialDuration;
  bool _isRunning = false;
  bool _isPaused = false;
  late Future<void> Function()? _onComplete;

  Duration get duration => _duration;
  String get durationString {
    int hours = _duration.inHours;
    int minutes = _duration.inMinutes % 60;
    int seconds = _duration.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool get isRunning => _isRunning;
  bool get isPaused => _isPaused;

  TimerProvider() {
    _duration = const Duration();
    _initialDuration = const Duration();
  }

  void setDuration(Duration duration) {
    _duration = duration;
    _initialDuration = duration;
    notifyListeners();
  }

  void start() async {
    if (_duration.inSeconds <= 0) return;

    _isRunning = true;
    _isPaused = false;
    notifyListeners();

    while (_duration.inSeconds > 0 && _isRunning) {
      await Future.delayed(const Duration(seconds: 1), () {
        if (_isRunning && !_isPaused) {
          _duration = _duration - const Duration(seconds: 1);
          notifyListeners();
        }
      });
    }

    if (_duration.inSeconds == 0) {
      _isRunning = false;
      if (_onComplete != null) {
        await _onComplete!();
      }
      notifyListeners();
    }
  }

  void pause() {
    _isPaused = true;
    notifyListeners();
  }

  void resume() {
    _isPaused = false;
    notifyListeners();
    start();
  }

  void stop() {
    _isRunning = false;
    _isPaused = false;
    _duration = _initialDuration;
    notifyListeners();
  }

  void reset() {
    _isRunning = false;
    _isPaused = false;
    _duration = _initialDuration;
    notifyListeners();
  }
}
