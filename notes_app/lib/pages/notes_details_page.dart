import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/models/note.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/models/note_database.dart';

class NotesDetailsPage extends StatefulWidget {
  final Note note; // Recebe a nota que foi passada

  const NotesDetailsPage({super.key, required this.note});

  @override
  _NotesDetailsPageState createState() => _NotesDetailsPageState();
}

class _NotesDetailsPageState extends State<NotesDetailsPage> {
  late TextEditingController titleController;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    // Inicializa o controlador de texto com o conteúdo da nota
    titleController = TextEditingController(text: widget.note.title);
    textController = TextEditingController(text: widget.note.text);
  }

  // Função para salvar a nota
  void saveNote() {
    context.read<NoteDatabase>().updateNote(
          widget.note.id,
          titleController.text,
          textController.text,
          widget.note.folder.value!.id,
        );

    Navigator.pop(context); // Retorna à página anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(Icons.check,
                color: Theme.of(context).colorScheme.inversePrimary),
            onPressed: saveNote,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                ),
                style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(20),
              child: Expanded(
                child: TextField(
                  controller: textController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your note here',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
