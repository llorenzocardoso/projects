import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function()? onDeleteTap;

  const NoteSettings({
    super.key,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onDeleteTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Text(
                'Delete',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
