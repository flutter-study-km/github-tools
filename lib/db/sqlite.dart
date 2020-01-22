import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:github_tools/models/meta.dart';


Future<Database> connectDB() async {
  return openDatabase(
    join(await getDatabasesPath(), 'github_tools_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE meta(id INTEGER PRIMARY KEY, token TEXT, password TEXT, count INTEGER)",
      );
    },
    version: 1,
  );
}

Future<void> insertMeta(Meta meta) async {
  final Database db = await connectDB();

  await db.insert(
    'meta',
    meta.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Meta>> metas() async {
  final Database db = await connectDB();

  final List<Map<String, dynamic>> maps = await db.query('meta');

  return List.generate(maps.length, (i) {
    return Meta(
      id: maps[i]['id'],
      token: maps[i]['token'],
      password: maps[i]['password'],
      count: maps[i]['count'],
    );
  });
}

Future<void> updateMeta(Meta meta) async {
  final db = await connectDB();

  await db.update(
    'meta',
    meta.toMap(),
    where: "id = ?",
    whereArgs: [meta.id],
  );
}

Future<void> deleteDog(int id) async {
  final db = await connectDB();

  await db.delete(
    'meta',
    where: "id = ?",
    whereArgs: [id],
  );
}
