import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_utility_toolkit/models/calculator_history_model.dart';
import 'package:smart_utility_toolkit/models/note_model.dart';
import 'package:smart_utility_toolkit/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  late Box<TodoModel> _todoBox;
  late Box<NoteModel> _noteBox;
  late Box<CalculatorHistoryModel> _calculatorHistoryBox;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoModelAdapter());
    Hive.registerAdapter(NoteModelAdapter());
    Hive.registerAdapter(CalculatorHistoryModelAdapter());

    _todoBox = await Hive.openBox<TodoModel>('todos');
    _noteBox = await Hive.openBox<NoteModel>('notes');
    _calculatorHistoryBox = await Hive.openBox<CalculatorHistoryModel>('calculator_history');
  }

  // Todo Methods
  Future<void> addTodo(TodoModel todo) async {
    await _todoBox.put(todo.id, todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _todoBox.put(todo.id, todo);
  }

  Future<void> deleteTodo(String id) async {
    await _todoBox.delete(id);
  }

  List<TodoModel> getAllTodos() {
    return _todoBox.values.toList();
  }

  TodoModel? getTodoById(String id) {
    return _todoBox.get(id);
  }

  List<TodoModel> getTodosByCategory(String category) {
    return _todoBox.values.where((todo) => todo.category == category).toList();
  }

  List<TodoModel> getCompletedTodos() {
    return _todoBox.values.where((todo) => todo.isCompleted).toList();
  }

  List<TodoModel> getPendingTodos() {
    return _todoBox.values.where((todo) => !todo.isCompleted).toList();
  }

  // Note Methods
  Future<void> addNote(NoteModel note) async {
    await _noteBox.put(note.id, note);
  }

  Future<void> updateNote(NoteModel note) async {
    await _noteBox.put(note.id, note);
  }

  Future<void> deleteNote(String id) async {
    await _noteBox.delete(id);
  }

  List<NoteModel> getAllNotes() {
    final notes = _noteBox.values.toList();
    notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return notes;
  }

  NoteModel? getNoteById(String id) {
    return _noteBox.get(id);
  }

  List<NoteModel> searchNotes(String query) {
    return _noteBox.values
        .where((note) => note.title.toLowerCase().contains(query.toLowerCase()) || note.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Calculator History Methods
  Future<void> addCalculatorHistory(CalculatorHistoryModel history) async {
    await _calculatorHistoryBox.put(history.id, history);
  }

  List<CalculatorHistoryModel> getCalculatorHistory() {
    final history = _calculatorHistoryBox.values.toList();
    history.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return history;
  }

  Future<void> clearCalculatorHistory() async {
    await _calculatorHistoryBox.clear();
  }

  // Generate unique ID
  static String generateId() {
    return const Uuid().v4();
  }
}
