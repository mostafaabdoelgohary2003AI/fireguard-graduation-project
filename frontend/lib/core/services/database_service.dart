import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/notification_payload.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('fire_guard.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('DROP TABLE IF EXISTS notifications');
          await _createDB(db, newVersion);
        }
      },
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notifications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        event_id TEXT UNIQUE,
        camera_id TEXT,
        camera_name TEXT,
        location TEXT,
        zone TEXT,
        event_type TEXT,
        ai_confidence REAL,
        detected_at TEXT
      )
    ''');
  }

  Future<void> insertNotification(AlertPayload payload) async {
    final db = await instance.database;
    await db.insert(
      'notifications', 
      payload.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<AlertPayload>> getAllNotifications() async {
    final db = await instance.database;
    final result = await db.query('notifications', orderBy: 'detected_at DESC');

    return result.map((json) => AlertPayload.fromMap(json)).toList();
  }

  Future<void> clearAll() async {
    final db = await instance.database;
    await db.delete('notifications');
  }
}
