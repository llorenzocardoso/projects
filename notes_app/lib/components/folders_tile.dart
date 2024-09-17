import 'package:flutter/material.dart';
import 'package:notes_app/components/folder_settings.dart';
import 'package:popover/popover.dart';

class FoldersTile extends StatelessWidget {
  final String name;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  final void Function()? onTap;

  const FoldersTile({
    super.key,
    required this.name,
    required this.onEditPressed,
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
        onTap: onTap,
        title: Text(
          name,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        trailing: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => showPopover(
              height: 100,
              width: 100,
              backgroundColor: Theme.of(context).colorScheme.surface,
              context: context,
              bodyBuilder: (context) => NoteSettings(
                onEditTap: onEditPressed,
                onDeleteTap: onDeletePressed,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
