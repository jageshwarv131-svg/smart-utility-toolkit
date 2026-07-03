import 'package:flutter/material.dart';

class EMICalculatorProvider extends ChangeNotifier {
  double _principal = 0; // Loan amount
  double _interestRate = 0; // Annual interest rate
  int _loanDuration = 0; // In months
  double _emi = 0;
  double _totalAmount = 0;
  double _totalInterest = 0;
  List<Map<String, dynamic>> _amortizationSchedule = [];

  double get principal => _principal;
  double get interestRate => _interestRate;
  int get loanDuration => _loanDuration;
  double get emi => _emi;
  double get totalAmount => _totalAmount;
  double get totalInterest => _totalInterest;
  List<Map<String, dynamic>> get amortizationSchedule => _amortizationSchedule;

  void setPrincipal(double principal) {
    _principal = principal;
    _calculateEMI();
    notifyListeners();
  }

  void setInterestRate(double rate) {
    _interestRate = rate;
    _calculateEMI();
    notifyListeners();
  }

  void setLoanDuration(int duration) {
    _loanDuration = duration;
    _calculateEMI();
    notifyListeners();
  }

  void _calculateEMI() {
    if (_principal <= 0 || _interestRate < 0 || _loanDuration <= 0) {
      _emi = 0;
      _totalAmount = 0;
      _totalInterest = 0;
      _amortizationSchedule = [];
      return;
    }

    double monthlyRate = _interestRate / 100 / 12;

    if (monthlyRate == 0) {
      _emi = _principal / _loanDuration;
    } else {
      _emi = (_principal * monthlyRate * pow(1 + monthlyRate, _loanDuration)) / (pow(1 + monthlyRate, _loanDuration) - 1);
    }

    _totalAmount = _emi * _loanDuration;
    _totalInterest = _totalAmount - _principal;

    _generateAmortizationSchedule();
  }

  void _generateAmortizationSchedule() {
    _amortizationSchedule = [];
    double balance = _principal;
    double monthlyRate = _interestRate / 100 / 12;

    for (int month = 1; month <= _loanDuration; month++) {
      double interestPayment = balance * monthlyRate;
      double principalPayment = _emi - interestPayment;
      balance -= principalPayment;

      _amortizationSchedule.add({
        'month': month,
        'payment': _emi,
        'principal': principalPayment,
        'interest': interestPayment,
        'balance': balance < 0 ? 0 : balance,
      });
    }
  }

  double pow(double base, num exp) {
    return base == 0 ? 0 : math.pow(base, exp).toDouble();
  }
}

import 'dart:math' as math;
