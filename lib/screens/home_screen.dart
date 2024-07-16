import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

import 'package:notes_app/screens/note_detail_screen.dart';
import 'package:notes_app/service/database_helper.dart';
import 'package:notes_app/widgets/note_list_item.dart';


class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  HomeScreen({required this.onToggleTheme});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  _refreshNotes() async {
    List<Note> notes = await _dbHelper.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  _deleteNote (int id) async {
    await _dbHelper.delete(id);
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          return NoteItem(
            note: _notes[index],
            onDelete: () => _deleteNote(_notes[index].id!),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoteDetailScreen(note: _notes[index])),
              );
              _refreshNotes();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteDetailScreen()),
          );
          _refreshNotes();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
