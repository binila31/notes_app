import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';


class NoteItem extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  NoteItem({required this.note, required this.onDelete, required this.onTap});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: theme.cardColor, // Use cardColor for background
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: theme.textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text(
              note.content,
              style: theme.textTheme.bodyText2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
