import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes_app/components/drawer_tile.dart';
import 'package:notes_app/models/folder.dart';
import 'package:notes_app/models/folder_database.dart';
import 'package:notes_app/pages/folders_page.dart';
import 'package:notes_app/pages/notes_page.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // header
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: const DividerThemeData(color: Colors.transparent),
            ),
            child: DrawerHeader(
              child: Icon(
                Icons.edit,
                size: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          const SizedBox(height: 25),

          DrawerTile(
            title: 'Folders',
            leading: const Icon(Icons.folder),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FoldersPage(),
                ),
              );
            },
          ),

          DrawerTile(
            title: 'Notes',
            leading: const Icon(Icons.home),
            onTap: () async {
              Navigator.pop(context);

              // Mostra um indicador de carregamento enquanto a pasta é carregada/criada
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );

              final folderId = await _getOrCreateDefaultFolderId();

              // Remove o diálogo de carregamento
              Navigator.pop(context);

              if (folderId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotesPage(folderId: folderId),
                  ),
                );
              } else {
                // Exibir uma mensagem de erro caso ocorra algum problema
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Failed to load or create the "Notes" folder.')),
                );
              }
            },
          ),

          DrawerTile(
            title: 'Settings',
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Função modular para buscar ou criar a pasta "Notes"
  Future<int?> _getOrCreateDefaultFolderId() async {
    // Verificar se a lista de pastas está vazia
    final allFolders = await FolderDatabase.isar.folders.where().findAll();

    if (allFolders.isEmpty) {
      // Se não houver pastas, cria uma nova pasta "Notes"
      final newFolder = Folder()..name = 'Notes';
      await FolderDatabase.isar.writeTxn(() async {
        await FolderDatabase.isar.folders.put(newFolder);
      });

      return newFolder.id; // Retorna o ID da nova pasta criada
    } else {
      // Se houver pastas, verifica se a pasta "Notes" existe
      final folder = await FolderDatabase.isar.folders
          .filter()
          .nameEqualTo('Notes')
          .findFirst();

      if (folder != null) {
        return folder.id; // Retorna o ID da pasta "Notes" existente
      } else {
        // Se a pasta "Notes" não existir, retorna o ID da primeira pasta encontrada
        return allFolders.first.id;
      }
    }
  }
}
