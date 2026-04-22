class BancoDeDados {
  static final BancoDeDados instancia = BancoDeDados._iniciar();
  BancoDeDados._iniciar();

  final Map<String, List<String>> _exerciciosSalvos = {};

  Future<void> inserirExercicio(String dia, String nome) async {
    if (!_exerciciosSalvos.containsKey(dia)) {
      _exerciciosSalvos[dia] = [];
    }
    _exerciciosSalvos[dia]!.add(nome);
  }

  Future<List<String>> pegarExerciciosDoDia(String dia) async {
    return _exerciciosSalvos[dia] ?? [];
  }
}