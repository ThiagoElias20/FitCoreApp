import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath(); // Obtém o diretório do banco
    final dbPath = join(path, 'alimentos.db'); // Define o nome do banco

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE alimentos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            calorias REAL,
            porcao TEXT,
            proteinas REAL,
            carboidratos REAL,
            gorduras REAL,
            imagem TEXT
          )
        ''');
      },
    );
  }

  Future<int> inserirAlimento(Map<String, dynamic> alimento) async {
    final db = await database; // Obtém o banco de dados
    return await db.insert('alimentos', alimento); // Insere os dados na tabela
  }

  Future<List<Map<String, dynamic>>> listarAlimentos() async {
    final db = await database;
    return await db.query('alimentos'); // Retorna todos os alimentos salvos
  }

  Future<void> listarAlimentosNoConsole() async {
    final db = await database;
    final alimentos = await db.query('alimentos');

    print("📋 Lista de Alimentos no Banco:");
    for (var alimento in alimentos) {
      print(alimento);
    }
  }
}