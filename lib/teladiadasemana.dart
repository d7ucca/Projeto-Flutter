import 'package:flutter/material.dart';

class TelaDiaSemana extends StatefulWidget {
  final String usuarioId;
  final String dia;
  final List<String> exercicios;

  const TelaDiaSemana({
    super.key,
    required this.usuarioId,
    required this.dia,
    required this.exercicios,
  });

  @override
  State<TelaDiaSemana> createState() => _TelaDiaSemanaState();
}

class _TelaDiaSemanaState extends State<TelaDiaSemana> {
  late List<String> lista;

  @override
  void initState() {
    super.initState();
    lista = widget.exercicios;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: Text(widget.dia.toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: lista.isEmpty
            ? const Center(
                child: Text(
                  "Nenhum exercício cadastrado para este dia.",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xFF1E1E1E),
                    child: ListTile(
                      leading: const Icon(
                        Icons.fitness_center,
                        color: Color(0xFF2EFE2E),
                      ),
                      title: Text(
                        lista[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}