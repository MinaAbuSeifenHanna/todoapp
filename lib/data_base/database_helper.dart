import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  // Singleton pattern to create a single instance of the database
  static final DBHelper instance = DBHelper._init();
  static Database? _database;
  DBHelper._init();

  // Initialize the database
  Future<Database> get database  async{
    if (_database != null) return _database!;
    _database = await _initializeDB('note.db');
    return _database!;
  }
  // Method to initialize the database
  Future<Database> _initializeDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }
  // Method to create the tables
  Future _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, note TEXT NOT NULL, dateTime TEXT NOT NULL )',
    );
  }
  // Method to insert a new note
  Future<void> insertNote(String note, String datetime) async {
    final db = await instance.database;
    await db.insert(
      'notes',
      {
        'note': note,
        'dateTime': datetime,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Method to get all Notes
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await instance.database;
    return await db.query('notes');
  }


  // Close the database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
