import 'package:isar/isar.dart';
import 'package:notes_app/models/folder.dart';
part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String title;
  late String text;
  final folder = IsarLink<Folder>();
}