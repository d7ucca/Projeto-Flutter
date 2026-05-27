import 'package:flutter/material.dart';
import 'banco.dart';
import 'teladiadasemana.dart';

class TelaHome extends StatefulWidget {
  final String usuarioId;
  final String nome;

  const TelaHome({super.key, required this.usuarioId, required this.nome});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  final List<String> dias = [
    'segunda',
    'terca',
    'quarta',
    'quinta',
    'sexta',
    'sabado',
    'domingo',
  ];

  Future<List<String>> carregar(String dia) async {
    List<String> exercicios = await BancoDeDados.instancia.pegarExerciciosDoDia(
      widget.usuarioId,
      dia,
    );

    if (exercicios.isEmpty) {
      await BancoDeDados.instancia.inserirExercicio(
        widget.usuarioId,
        dia,
        "SUPINO RETO - 4x10",
      );

      await BancoDeDados.instancia.inserirExercicio(
        widget.usuarioId,
        dia,
        "AGACHAMENTO - 3x12",
      );

      exercicios = await BancoDeDados.instancia.pegarExerciciosDoDia(
        widget.usuarioId,
        dia,
      );
    }

    return exercicios;
  }

  Widget botao(String dia) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 60),
          backgroundColor: const Color(0xFF1E1E1E),
        ),
        onPressed: () async {
          final exercicios = await carregar(dia);

          if (!mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaDiaSemana(
                usuarioId: widget.usuarioId,
                dia: dia,
                exercicios: exercicios,
              ),
            ),
          );
        },
        child: Text(dia.toUpperCase()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: Text("Bem-vindo ${widget.nome}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: dias.map((d) => botao(d)).toList()),
      ),
    );
  }
}
