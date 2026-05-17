import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('gamevault.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {

    final dbPath = await getDatabasesPath();

    final path = join(
      dbPath,
      fileName,
    );

    print(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE games (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        plataforma TEXT NOT NULL,
        categoria TEXT NOT NULL,
        status TEXT NOT NULL,
        raridade TEXT NOT NULL,
        valorPago REAL NOT NULL,
        valorEstimado REAL NOT NULL,
        localizacao TEXT,
        observacoes TEXT,
        imagem TEXT
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}