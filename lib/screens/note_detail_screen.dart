import 'package:flutter/material.dart';
import 'package:notes_app/service/database_helper.dart';
import 'package:notes_app/models/note.dart';


class NoteDetailScreen extends StatefulWidget {
  final Note? note;
  NoteDetailScreen({this.note});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  _saveNote() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) return;
    Note note = Note(
      id: widget.note?.id,
      title: _titleController.text,
      content: _contentController.text,
      date: DateTime.now().toIso8601String(),
    );
    if (widget.note == null) {
      await _dbHelper.add(note);
    } else {
      await _dbHelper.update(note);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(hintText: 'Content'),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
