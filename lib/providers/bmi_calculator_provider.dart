import 'package:flutter/material.dart';

class BMICalculatorProvider extends ChangeNotifier {
  double _height = 0; // in cm
  double _weight = 0; // in kg
  double _bmi = 0;
  String _bmiCategory = '';
  String _bmiStatus = '';
  Color _statusColor = Colors.grey;

  double get height => _height;
  double get weight => _weight;
  double get bmi => _bmi;
  String get bmiCategory => _bmiCategory;
  String get bmiStatus => _bmiStatus;
  Color get statusColor => _statusColor;

  void setHeight(double height) {
    _height = height;
    _calculateBMI();
    notifyListeners();
  }

  void setWeight(double weight) {
    _weight = weight;
    _calculateBMI();
    notifyListeners();
  }

  void _calculateBMI() {
    if (_height <= 0 || _weight <= 0) {
      _bmi = 0;
      _bmiCategory = '';
      _bmiStatus = '';
      _statusColor = Colors.grey;
      return;
    }

    double heightInMeters = _height / 100;
    _bmi = _weight / (heightInMeters * heightInMeters);

    if (_bmi < 18.5) {
      _bmiCategory = 'Underweight';
      _bmiStatus = 'Below normal weight';
      _statusColor = Colors.blue;
    } else if (_bmi >= 18.5 && _bmi < 25) {
      _bmiCategory = 'Normal Weight';
      _bmiStatus = 'Healthy weight range';
      _statusColor = Colors.green;
    } else if (_bmi >= 25 && _bmi < 30) {
      _bmiCategory = 'Overweight';
      _bmiStatus = 'Above normal weight';
      _statusColor = Colors.orange;
    } else {
      _bmiCategory = 'Obese';
      _bmiStatus = 'Significantly above normal weight';
      _statusColor = Colors.red;
    }
  }
}
