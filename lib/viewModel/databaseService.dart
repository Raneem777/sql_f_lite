import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sql_f_lite/model/data.dart';

class DatabaseService {
   Future<Database> initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'notes_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, note TEXT)',
        );
      },
      version: 1,
    );
  }
  

  Future<void> insertNotes(User user) async {
    final db = await initDB();
    await db.insert('notes', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<User>> getnotes() async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  Future<void> updateNotes(User user) async {
    final db = await initDB();
    await db
        .update('notes', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<void> deleteNotes(int id) async {
    final db = await initDB();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
