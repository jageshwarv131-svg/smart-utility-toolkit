import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit/models/todo_model.dart';
import 'package:smart_utility_toolkit/services/database_service.dart';

class TodoProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<TodoModel> _todos = [];
  List<TodoModel> _filteredTodos = [];
  String _filterCategory = 'All';
  String _searchQuery = '';

  List<TodoModel> get todos => _filteredTodos;
  String get filterCategory => _filterCategory;
  String get searchQuery => _searchQuery;

  TodoProvider() {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    _todos = _databaseService.getAllTodos();
    _applyFilters();
  }

  Future<void> addTodo(String title, String description, String category, int priority, DateTime? dueDate, List<String> tags) async {
    final todo = TodoModel(
      id: DatabaseService.generateId(),
      title: title,
      description: description,
      category: category,
      priority: priority,
      dueDate: dueDate,
      tags: tags,
    );
    await _databaseService.addTodo(todo);
    await _loadTodos();
    notifyListeners();
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _databaseService.updateTodo(todo);
    await _loadTodos();
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    await _databaseService.deleteTodo(id);
    await _loadTodos();
    notifyListeners();
  }

  Future<void> toggleTodoCompletion(String id) async {
    final todo = _databaseService.getTodoById(id);
    if (todo != null) {
      todo.isCompleted = !todo.isCompleted;
      await _databaseService.updateTodo(todo);
      await _loadTodos();
      notifyListeners();
    }
  }

  void setFilterCategory(String category) {
    _filterCategory = category;
    _applyFilters();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredTodos = _todos;

    // Apply category filter
    if (_filterCategory != 'All') {
      _filteredTodos = _filteredTodos.where((todo) => todo.category == _filterCategory).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((todo) => todo.title.toLowerCase().contains(_searchQuery.toLowerCase()) || todo.description.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Sort by priority and due date
    _filteredTodos.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      if (a.priority != b.priority) {
        return b.priority.compareTo(a.priority);
      }
      if (a.dueDate != null && b.dueDate != null) {
        return a.dueDate!.compareTo(b.dueDate!);
      }
      return 0;
    });
  }

  List<String> getCategories() {
    return ['All', ..._todos.map((todo) => todo.category).toSet().toList()];
  }

  int getCompletedCount() {
    return _todos.where((todo) => todo.isCompleted).length;
  }

  int getTotalCount() {
    return _todos.length;
  }
}
