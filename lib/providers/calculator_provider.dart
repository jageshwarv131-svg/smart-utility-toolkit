import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  String _display = '0';
  String _operation = '';
  double _previousValue = 0;
  bool _shouldResetDisplay = false;

  String get display => _display;

  void inputNumber(String number) {
    if (_shouldResetDisplay) {
      _display = number;
      _shouldResetDisplay = false;
    } else {
      if (_display == '0') {
        _display = number;
      } else {
        _display += number;
      }
    }
    notifyListeners();
  }

  void inputDecimal() {
    if (!_display.contains('.')) {
      _display += '.';
    }
    notifyListeners();
  }

  void inputOperation(String operation) {
    _previousValue = double.tryParse(_display) ?? 0;
    _operation = operation;
    _shouldResetDisplay = true;
    notifyListeners();
  }

  void calculate() {
    try {
      double currentValue = double.tryParse(_display) ?? 0;
      double result = 0;

      switch (_operation) {
        case '+':
          result = _previousValue + currentValue;
          break;
        case '-':
          result = _previousValue - currentValue;
          break;
        case '×':
          result = _previousValue * currentValue;
          break;
        case '÷':
          if (currentValue != 0) {
            result = _previousValue / currentValue;
          }
          break;
        case '%':
          result = _previousValue % currentValue;
          break;
      }

      _display = result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 2);
      _operation = '';
      _shouldResetDisplay = true;
    } catch (e) {
      _display = 'Error';
    }
    notifyListeners();
  }

  void clear() {
    _display = '0';
    _operation = '';
    _previousValue = 0;
    _shouldResetDisplay = false;
    notifyListeners();
  }

  void backspace() {
    if (_display.isNotEmpty && _display != '0') {
      _display = _display.substring(0, _display.length - 1);
      if (_display.isEmpty) {
        _display = '0';
      }
    }
    notifyListeners();
  }

  void toggleSign() {
    try {
      double value = double.tryParse(_display) ?? 0;
      value = -value;
      _display = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } catch (e) {
      _display = 'Error';
    }
    notifyListeners();
  }

  void calculatePercentage() {
    try {
      double value = double.tryParse(_display) ?? 0;
      value = value / 100;
      _display = value.toStringAsFixed(4);
    } catch (e) {
      _display = 'Error';
    }
    notifyListeners();
  }
}
