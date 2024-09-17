import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/drawer.dart';
import 'package:notes_app/components/folders_tile.dart';
import 'package:notes_app/models/folder.dart';
import 'package:notes_app/models/folder_database.dart';
import 'package:notes_app/pages/notes_page.dart';
import 'package:provider/provider.dart';

class FoldersPage extends StatefulWidget {
  const FoldersPage({super.key});

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    readFolders();
  }

  // read folders
  void readFolders() {
    context.read<FolderDatabase>().fetchFolders();
  }

  // delete a folder
  void deleteNote(int id) {
    context.read<FolderDatabase>().deleteFolder(id);
  }

  // update a folder
  void updateFolder(Folder folder) {
    textController.text = folder.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('Update Folder'),
        content: TextField(controller: textController),
        actions: [
          MaterialButton(
            onPressed: () {
              context
                  .read<FolderDatabase>()
                  .updateFolder(folder.id, textController.text);
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // create a folder
  void createFolder() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<FolderDatabase>().addFolder(textController.text);
              textController.clear();
              Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    final folderDatabase = context.watch<FolderDatabase>();

    List<Folder> currentFolders = folderDatabase.currentFolders;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createFolder(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.edit,
            color: Theme.of(context).colorScheme.inversePrimary),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Folders',
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          // list of folders
          Expanded(
            child: ListView.builder(
              itemCount: currentFolders.length,
              itemBuilder: (context, index) {
                final folder = currentFolders[index];

                return FoldersTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotesPage(folderId: folder.id),
                      ),
                    );
                  },
                  name: folder.name,
                  onEditPressed: () => updateFolder(folder),
                  onDeletePressed: () => deleteNote(folder.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
