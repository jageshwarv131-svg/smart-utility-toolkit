import 'package:flutter/material.dart';

class TextCounterProvider extends ChangeNotifier {
  String _text = '';
  int _characters = 0;
  int _words = 0;
  int _lines = 0;
  int _sentences = 0;
  int _paragraphs = 0;

  String get text => _text;
  int get characters => _characters;
  int get words => _words;
  int get lines => _lines;
  int get sentences => _sentences;
  int get paragraphs => _paragraphs;

  void setText(String newText) {
    _text = newText;
    _calculateStats();
    notifyListeners();
  }

  void _calculateStats() {
    // Count characters
    _characters = _text.length;

    // Count words
    _words = _text.trim().isEmpty ? 0 : _text.trim().split(RegExp(r'\s+')).length;

    // Count lines
    _lines = _text.isEmpty ? 0 : _text.split('\n').length;

    // Count sentences
    _sentences = _text.split(RegExp(r'[.!?]')).where((s) => s.trim().isNotEmpty).length;

    // Count paragraphs
    _paragraphs = _text.split(RegExp(r'\n\n+')).where((p) => p.trim().isNotEmpty).length;
  }

  void clear() {
    _text = '';
    _calculateStats();
    notifyListeners();
  }
}
