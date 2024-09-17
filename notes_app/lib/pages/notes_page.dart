import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/components/notes_tile.dart';
import 'package:notes_app/pages/notes_details_page.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class NotesPage extends StatefulWidget {
  final Id folderId;
  const NotesPage({super.key, required this.folderId});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // Text controller para o título
  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  // Função para criar a nota
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(hintText: 'Note Title'),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              final newNote = await context
                  .read<NoteDatabase>()
                  .addNote(titleController.text, widget.folderId);
              
              titleController.clear();

              Navigator.pop(context); // Fecha o diálogo
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesDetailsPage(note: newNote),
                ),
              );
            },
            child: const Text('Create'),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // Função para ler as notas
  void readNotes() {
    context.read<NoteDatabase>().fetchNotesByFolder(widget.folderId);
  }

  // Função para deletar uma nota
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id, widget.folderId);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNote(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.edit,
            color: Theme.of(context).colorScheme.inversePrimary),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          // Lista de notas
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];

                return NotesTile(
                  title: note.title,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotesDetailsPage(note: note),
                    ),
                  ),
                  onDeletePressed: () => deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
