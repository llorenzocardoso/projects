import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes_app/models/folder.dart';
import 'package:notes_app/models/note.dart';
import 'package:path_provider/path_provider.dart';

class FolderDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema, FolderSchema],
      directory: dir.path,
    );
  }

  final List<Folder> currentFolders = [];

  Future<void> addDefaultFolder() async {
    final existingFolders = await isar.folders.where().findAll();
    final hasDefaultFolder =
        existingFolders.any((folder) => folder.name == 'Notes');

    if (!hasDefaultFolder) {
      final defaultFolder = Folder()..name = 'Notes';
      await isar.writeTxn(() async {
        await isar.folders.put(defaultFolder);
      });
    }
  }

  Future<void> addFolder(String text) async {
    final newFolder = Folder()..name = text;

    await isar.writeTxn(() => isar.folders.put(newFolder));

    fetchFolders();
  }

  Future<void> fetchFolders() async {
    List<Folder> fetchedFolders = await isar.folders.where().findAll();
    currentFolders.clear();
    currentFolders.addAll(fetchedFolders);

    notifyListeners();
  }

  Future<void> updateFolder(int id, String newText) async {
    final existingFolder = await isar.folders.get(id);

    if (existingFolder != null) {
      existingFolder.name = newText;
      await isar.writeTxn(() => isar.folders.put(existingFolder));
      await fetchFolders();
    }
  }

  Future<void> deleteFolder(int id) async {
    await isar.writeTxn(() => isar.folders.delete(id));
    await fetchFolders();
  }
}
