import 'package:aps_projeto/app/models/objetoCadast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DbUtil {
  static Future<sql.Database> databaseStatic() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      join(dbPath, 'tarefasAppFel.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tarefas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            classificacao TEXT,
            nomePessoa TEXT,
            dataDevolucao TEXT,
            observacoes TEXT
          )
          ''');
      },
      version: 1,
    );
    return db;
  }

  static Future<void> insertFormData(ObjetoCadastrar formData) async {
    final db = await databaseStatic();
    await db.insert(
      'tarefas',
      formData.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateFormData(ObjetoCadastrar formData) async {
    final db = await databaseStatic();
    await db.update(
      'tarefas',
      formData.toMap(),
      where: 'id = ?',
      whereArgs: [
        formData.id
      ], // Substitua "id" pelo nome da coluna de identificação
    );
  }

  static Future<void> deleteFormData(int id) async {
    final db = await databaseStatic();
    await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // static Future<List<ObjetoCadastrar>> getAllFormData() async {
  //   final db = await databaseStatic();
  //   final List<Map<String, dynamic>> maps = await db.query('tarefas');

  //   return List.generate(maps.length, (index) {
  //     return ObjetoCadastrar(
  //       id: maps[index]['id'],
  //       nome: maps[index]['nome'],
  //       classificacao: maps[index]['classificacao'],
  //       nomePessoa: maps[index]['nomePessoa'],
  //       dataDevolucao: maps[index]['dataDevolucao'],
  //       observacoes: maps[index]['observacoes'],
  //     );
  //   });
  // }

  static Future<List<ObjetoCadastrar>> getAllFormData(
      {String? searchText}) async {
    final db = await databaseStatic();

    // Construa a consulta SQL base
    String sql = 'SELECT * FROM tarefas';

    // Adicione uma cláusula WHERE se houver um texto de pesquisa
    List<dynamic> arguments = [];
    if (searchText != null && searchText.isNotEmpty) {
      arguments.add('%$searchText%');
      sql += ' WHERE nome LIKE ?';
    }

    // Execute a consulta
    final List<Map<String, dynamic>> maps = await db.rawQuery(sql, arguments);

    // Mapeie os resultados para objetos
    return List.generate(maps.length, (index) {
      return ObjetoCadastrar(
        id: maps[index]['id'],
        nome: maps[index]['nome'],
        classificacao: maps[index]['classificacao'],
        nomePessoa: maps[index]['nomePessoa'],
        dataDevolucao: maps[index]['dataDevolucao'],
        observacoes: maps[index]['observacoes'],
      );
    });
  }
}

 

  // Resto do seu código...

