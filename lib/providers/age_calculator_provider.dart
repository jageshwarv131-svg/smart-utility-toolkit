import 'package:flutter/material.dart';

class AgeCalculatorProvider extends ChangeNotifier {
  DateTime? _selectedDate;
  int _years = 0;
  int _months = 0;
  int _days = 0;

  DateTime? get selectedDate => _selectedDate;
  int get years => _years;
  int get months => _months;
  int get days => _days;

  void setDate(DateTime date) {
    _selectedDate = date;
    _calculateAge();
    notifyListeners();
  }

  void _calculateAge() {
    if (_selectedDate == null) return;

    final now = DateTime.now();
    int years = now.year - _selectedDate!.year;
    int months = now.month - _selectedDate!.month;
    int days = now.day - _selectedDate!.day;

    if (days < 0) {
      months--;
      final lastMonthDate = DateTime(now.year, now.month, 0);
      days += lastMonthDate.day;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    _years = years;
    _months = months;
    _days = days;
  }

  String getAgeString() {
    return '$_years years, $_months months, $_days days';
  }
}
