import 'package:flutter/material.dart';
import 'package:notes_app/models/folder_database.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/pages/folders_page.dart';
import 'package:provider/provider.dart';
import 'themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([NoteDatabase.init(), FolderDatabase.init()]);

  await FolderDatabase().addDefaultFolder();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteDatabase()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => FolderDatabase()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FoldersPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
