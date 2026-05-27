class BancoDeDados {
  static final BancoDeDados instancia = BancoDeDados._();
  BancoDeDados._();

  final Map<String, List<String>> _db = {};

  String _key(String usuarioId, String dia) {
    return "${usuarioId}_$dia";
  }

  Future<void> inserirExercicio(
    String usuarioId,
    String dia,
    String exercicio,
  ) async {
    final key = _key(usuarioId, dia);

    _db.putIfAbsent(key, () => []);
    _db[key]!.add(exercicio);
  }

  Future<List<String>> pegarExerciciosDoDia(
    String usuarioId,
    String dia,
  ) async {
    final key = _key(usuarioId, dia);
    return _db[key] ?? [];
  }
}
