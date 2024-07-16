import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY,
        title TEXT,
        content TEXT,
        date TEXT
      )
    ''');
  }

  Future<List<Note>> getNotes() async {
    Database db = await database;
    var notes = await db.query('notes', orderBy: 'date DESC');
    List<Note> noteList = notes.isNotEmpty ? notes.map((c) => Note.fromMap(c)).toList() : [];
    return noteList;
  }

  Future<int> add(Note note) async {
    Database db = await database;
    return await db.insert('notes', note.toMap());
  }

  Future<int> update(Note note) async {
    Database db = await database;
    return await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
