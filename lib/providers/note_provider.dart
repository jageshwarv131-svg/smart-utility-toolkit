import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit/models/note_model.dart';
import 'package:smart_utility_toolkit/services/database_service.dart';

class NoteProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<NoteModel> _notes = [];
  List<NoteModel> _filteredNotes = [];
  String _searchQuery = '';

  List<NoteModel> get notes => _filteredNotes;
  String get searchQuery => _searchQuery;

  NoteProvider() {
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    _notes = _databaseService.getAllNotes();
    _applySearch();
  }

  Future<void> addNote(String title, String content, String color) async {
    final note = NoteModel(
      id: DatabaseService.generateId(),
      title: title,
      content: content,
      color: color,
    );
    await _databaseService.addNote(note);
    await _loadNotes();
    notifyListeners();
  }

  Future<void> updateNote(NoteModel note) async {
    await _databaseService.updateNote(note);
    await _loadNotes();
    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    await _databaseService.deleteNote(id);
    await _loadNotes();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredNotes = _notes;
    } else {
      _filteredNotes = _databaseService.searchNotes(_searchQuery);
    }
  }
}
