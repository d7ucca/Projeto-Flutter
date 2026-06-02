import 'package:flutter/material.dart';
import 'banco.dart';
import 'teladiadasemana.dart';

class TelaHome extends StatefulWidget {
  final String usuarioId;
  final String nome;

  const TelaHome({
    super.key,
    required this.usuarioId,
    required this.nome,
  });

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

  bool carregando = false;

  Future<List<String>> carregar(String dia) async {
    if (widget.usuarioId == "1") {
      await BancoDeDados.instancia.criarExerciciosAlunoTeste();
    }

    final exercicios = await BancoDeDados.instancia.pegarExerciciosDoDia(
      widget.usuarioId,
      dia,
    );

    return exercicios;
  }

  Future<void> abrirDia(String dia) async {
    try {
      setState(() => carregando = true);

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
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao carregar exercícios: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => carregando = false);
      }
    }
  }

  Widget botao(String dia) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 60),
          backgroundColor: const Color(0xFF1E1E1E),
          foregroundColor: const Color(0xFF2EFE2E),
        ),
        onPressed: carregando ? null : () => abrirDia(dia),
        child: Text(
          dia.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
        child: carregando
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF2EFE2E),
                ),
              )
            : ListView(
                children: dias.map((d) => botao(d)).toList(),
              ),
      ),
    );
  }
}