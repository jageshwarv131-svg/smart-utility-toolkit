import 'package:hive/hive.dart';

part 'calculator_history_model.g.dart';

@HiveType(typeId: 2)
class CalculatorHistoryModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String expression;

  @HiveField(2)
  late String result;

  @HiveField(3)
  late DateTime timestamp;

  CalculatorHistoryModel({
    required this.id,
    required this.expression,
    required this.result,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expression': expression,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory CalculatorHistoryModel.fromMap(Map<String, dynamic> map) {
    return CalculatorHistoryModel(
      id: map['id'] ?? '',
      expression: map['expression'] ?? '',
      result: map['result'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
    );
  }
}
