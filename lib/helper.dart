import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sql_flutter/Model/DatabaseModel.dart';
import 'package:sql_flutter/Model/TableModel.dart';

class SqlHelper {
  //Create table
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE students(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        class TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

//Create database
// created_at: the time that the item was created. It will be automatically handled by SQLite
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dheerajprajapat.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  //Insert
  static Future<int> createItem(String title, String? descrption) async {
    final db = await SqlHelper.db();

    final data = {'title': title, 'class': descrption};
    final id = await db.insert('students', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // read all
  static Future<List<Map<String, dynamic>>> getItems(String tableName) async {
    final db = await SqlHelper.db();
    return db.query(tableName.toString(), orderBy: "id");
  }

  // read only one
  static Future<List<Map<String, Object?>>> getItem(int id) async {
    final db = await SqlHelper.db();
    return db.query('students', where: "id = ?", whereArgs: [id], limit: 1);
  }

  //update
  static Future<int> updateItem(
      int id, String title, String? descrption) async {
    final db = await SqlHelper.db();

    final data = {
      'title': title,
      'class': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('students', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  //delete
  static Future<void> deleteItem(int id) async {
    final db = await SqlHelper.db();
    try {
      await db.delete("students", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  //All Tables
  static Future<List<TableModel>> getAllTableNames() async {
    final db = await SqlHelper.db();

    List<Map> maps =
        await db.rawQuery('SELECT * FROM sqlite_master ORDER BY name');

    List<TableModel> tableNameList = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        try {
          tableNameList.add(TableModel(
              tableName: maps[i]['name'].toString(),
              tableCreationDate: maps[i]['time'].toString()));
        } catch (e) {
          print('Exeption : ' + e.toString());
        }
      }
    }
    return tableNameList;
  }
}
