import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sql_f_lite/model/data.dart';

class DatabaseService {
  static Future<Database> initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, phoneNumber INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertUser(User user) async {
    final db = await initDB();
    await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<User>> getUsers() async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  static Future<void> updateUser(User user) async {
    final db = await initDB();
    await db
        .update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<void> deleteUser(int id) async {
    final db = await initDB();
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
