import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static Database? _database; //obj para criar as conexoes

  // transformar esse classe em singleton
  //não permite instanciar outro obj enquanto um obj estiver ativo
  static final DbHelper instance = DbHelper._internal();

  //construtor privado
  DbHelper._internal();
  factory DbHelper() {
    return _instance; //retorna o obj já criado
  }

  //conexões do Banco de dados
  Future<Database> get database async {
    if (_database != null) {
      return _database!; //retorna o banco já criado
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    // pegar o local onde esta salvo o BD (path)
    final _dbPath = await getDatabasesPath();
    final path = join(_dbPath, "petshop.db");
    return await openDatabase(path);
  }
}
