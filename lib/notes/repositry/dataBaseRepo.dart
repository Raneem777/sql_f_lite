import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final dbProvider = Provider((ref) => DatabaseService());

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  Database? _database;
  DatabaseService._internal();
  factory DatabaseService() => _instance;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'appNotes_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, note TEXT)',
        );
      },
      version: 1,
    );
  }
}
