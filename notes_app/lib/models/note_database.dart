import 'package:isar/isar.dart';
import 'package:notes_app/models/folder.dart';
import 'package:notes_app/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema, FolderSchema],
      directory: dir.path,
    );
  }

  final List<Note> currentNotes = [];

  // C R E A T E - Retorna a nota criada
  Future<Note> addNote(String title, Id folderId) async {
    final folder = await isar.folders.get(folderId);

    final newNote = Note()
      ..title = title
      ..text = ''  // Inicializa o texto vazio
      ..folder.value = folder;

    await isar.writeTxn(() async {
      await isar.notes.put(newNote);
      await newNote.folder.save();
    });

    fetchNotesByFolder(folderId);
    return newNote;
  }

  // R E A D
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  // U P D A T E
  Future<void> updateNote(int id, String newTitle, String newText, Id folderId) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.title = newTitle;
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotesByFolder(folderId);
    }
  }

  // D E L E T E
  Future<void> deleteNote(int id, Id folderId) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotesByFolder(folderId);
  }

  // Fetch notes by folder
  Future<void> fetchNotesByFolder(int folderId) async {
    List<Note> fetchedNotes = await isar.notes
        .filter()
        .folder((q) => q.idEqualTo(folderId))
        .findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }
}
