import 'package:isar/isar.dart';
import 'package:notes_app/models/note.dart';

part 'folder.g.dart';

@Collection()
class Folder{
  Id id = Isar.autoIncrement;
  late String name;
  final notes = IsarLinks<Note>();
}