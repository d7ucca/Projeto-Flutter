import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDeDados {
  static final BancoDeDados instancia = BancoDeDados._();
  BancoDeDados._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _iniciarBanco();
    return _database!;
  }

  Future<Database> _iniciarBanco() async {
    final caminhoBanco = await getDatabasesPath();
    final caminho = join(caminhoBanco, 'academia.db');

    return await openDatabase(
      caminho,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE exercicios (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            usuario_id TEXT NOT NULL,
            dia TEXT NOT NULL,
            exercicio TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> inserirExercicio(
    String usuarioId,
    String dia,
    String exercicio,
  ) async {
    final db = await database;

    await db.insert(
      'exercicios',
      {
        'usuario_id': usuarioId,
        'dia': dia,
        'exercicio': exercicio,
      },
    );
  }

  Future<List<String>> pegarExerciciosDoDia(
    String usuarioId,
    String dia,
  ) async {
    final db = await database;

    final resultado = await db.query(
      'exercicios',
      where: 'usuario_id = ? AND dia = ?',
      whereArgs: [usuarioId, dia],
      orderBy: 'id ASC',
    );

    return resultado.map((linha) {
      return linha['exercicio'] as String;
    }).toList();
  }

  Future<void> criarExerciciosAlunoTeste() async {
    const usuarioId = "1";

    final jaExiste = await pegarExerciciosDoDia(usuarioId, "segunda");

    if (jaExiste.isNotEmpty) {
      return;
    }

    await inserirExercicio(usuarioId, "segunda", "SUPINO RETO - 4x10");
    await inserirExercicio(usuarioId, "segunda", "CRUCIFIXO - 3x12");
    await inserirExercicio(usuarioId, "segunda", "TRÍCEPS CORDA - 4x12");

    await inserirExercicio(usuarioId, "terca", "AGACHAMENTO LIVRE - 4x10");
    await inserirExercicio(usuarioId, "terca", "LEG PRESS - 4x12");
    await inserirExercicio(usuarioId, "terca", "PANTURRILHA - 4x20");

    await inserirExercicio(usuarioId, "quarta", "PUXADA FRONTAL - 4x10");
    await inserirExercicio(usuarioId, "quarta", "REMADA BAIXA - 4x12");
    await inserirExercicio(usuarioId, "quarta", "ROSCA DIRETA - 3x12");

    await inserirExercicio(usuarioId, "quinta", "DESENVOLVIMENTO - 4x10");
    await inserirExercicio(usuarioId, "quinta", "ELEVAÇÃO LATERAL - 4x12");
    await inserirExercicio(usuarioId, "quinta", "ABDOMINAL - 4x20");

    await inserirExercicio(usuarioId, "sexta", "STIFF - 4x10");
    await inserirExercicio(usuarioId, "sexta", "CADEIRA FLEXORA - 4x12");
    await inserirExercicio(usuarioId, "sexta", "GLÚTEO MÁQUINA - 4x15");

    await inserirExercicio(usuarioId, "sabado", "CARDIO - 30 MINUTOS");
    await inserirExercicio(usuarioId, "sabado", "ABDOMINAL PRANCHA - 3x1 MIN");

    await inserirExercicio(usuarioId, "domingo", "DESCANSO");
  }
}