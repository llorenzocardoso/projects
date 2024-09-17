import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import 'note_settings.dart';

class NotesTile extends StatelessWidget {
  final String title;
  final void Function()? onDeletePressed;
  final void Function()? onTap; // Adiciona callback para navegação

  const NotesTile({
    super.key,
    required this.title,
    required this.onDeletePressed,
    required this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 10,
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        onTap: onTap, 
        trailing: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => showPopover(
              height: 100,
              width: 100,
              backgroundColor: Theme.of(context).colorScheme.surface,
              context: context,
              bodyBuilder: (context) => NoteSettings(
                onDeleteTap: onDeletePressed, 
              ),
            ),
          ),
        ),
      ),
    );
  }
}
