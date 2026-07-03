import 'package:flutter/material.dart';
import 'dart:math';

class PasswordGeneratorProvider extends ChangeNotifier {
  String _password = '';
  bool _includeUppercase = true;
  bool _includeLowercase = true;
  bool _includeNumbers = true;
  bool _includeSymbols = false;
  int _length = 12;

  static const String _uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const String _lowercase = 'abcdefghijklmnopqrstuvwxyz';
  static const String _numbers = '0123456789';
  static const String _symbols = '!@#\$%^&*()_-+=[]{}|;:,.<>?';

  String get password => _password;
  bool get includeUppercase => _includeUppercase;
  bool get includeLowercase => _includeLowercase;
  bool get includeNumbers => _includeNumbers;
  bool get includeSymbols => _includeSymbols;
  int get length => _length;

  void setUppercase(bool value) {
    _includeUppercase = value;
    notifyListeners();
  }

  void setLowercase(bool value) {
    _includeLowercase = value;
    notifyListeners();
  }

  void setNumbers(bool value) {
    _includeNumbers = value;
    notifyListeners();
  }

  void setSymbols(bool value) {
    _includeSymbols = value;
    notifyListeners();
  }

  void setLength(int value) {
    _length = value;
    notifyListeners();
  }

  void generatePassword() {
    String chars = '';

    if (_includeUppercase) chars += _uppercase;
    if (_includeLowercase) chars += _lowercase;
    if (_includeNumbers) chars += _numbers;
    if (_includeSymbols) chars += _symbols;

    if (chars.isEmpty) {
      _password = '';
      notifyListeners();
      return;
    }

    final random = Random();
    _password = '';

    for (int i = 0; i < _length; i++) {
      _password += chars[random.nextInt(chars.length)];
    }

    notifyListeners();
  }
}
