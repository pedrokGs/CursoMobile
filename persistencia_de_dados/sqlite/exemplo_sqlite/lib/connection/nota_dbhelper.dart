import 'dart:io';

import 'package:exemplo_sqlite/model/nota_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotaDBHelper {
  static const String db_nome = 'notas.db';
  static const String table_nome = 'notas';
  static const String create_table =
      'CREATE TABLE IF NOT EXISTS notas (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, conteudo, TEXT)';

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), db_nome),
      onCreate: (db, version) {
        return db.execute(create_table);
      },
      version: 1,
    );
  }

  Future<void> create (Nota nota) async{
    try {
      final Database db = await _getDatabase();
      await db.insert(table_nome, nota.toMap());
    } catch (e) {
      print("Deu erro: {$e}");
      return;
    }
  }

  Future<List<Nota>> getNotas() async {
    try {
  final Database db = await _getDatabase();
  final List<Map<String, dynamic>> maps = await db.query(table_nome);
  return List.generate(maps.length, (i)=> Nota.fromMap(maps[i]));
} on Exception catch (e) {
  print(e);
  return [];
}
  }

  Future<void> updateNota (Nota nota) async {
    try {
      final db = await _getDatabase();
      await db.update(table_nome, nota.toMap(), where: 'id = ?', whereArgs: [nota.id]);
    } catch (e) {
      print (e);
    }
  }

  Future<void> deleteNota(int id) async{
    try {
      final Database db = await _getDatabase();
      await db.delete(table_nome, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> clearNotes() async{
    try {
      final db = await _getDatabase();
      await db.delete(table_nome);
    } catch (e) {
      print(e);
    }
  }
}
