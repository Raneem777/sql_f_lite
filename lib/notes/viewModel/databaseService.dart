import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_f_lite/notes/repositry/dataBaseRepo.dart';
import 'package:sql_f_lite/notes/repositry/model/data.dart';

final noteDataBaseClient =
    Provider((ref) => DataBaseClient(ref.watch(dbProvider)));

class DataBaseClient {
  DatabaseService services;
  DataBaseClient(this.services);

  Future<int> insertNotes(User user) async {
    final db = await services.database;
    await db.insert('notes', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return 200;
    // print('Inserted Note: ${user.title}');
  }

  Future<List<User>> getnotes() async {
    final db = await services.database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    print("Raw data fetched from database: $maps");

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  Future<void> updateNotes(User user) async {
    final db = await services.database;
    await db
        .update('notes', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<void> deleteNotes(int id) async {
    final db = await services.database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
