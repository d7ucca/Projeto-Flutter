import 'package:flutter/material.dart';
import 'banco.dart';

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
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    lista = widget.exercicios;
  }

  Future<void> adicionar() async {
    final texto = controller.text.trim();
    if (texto.isEmpty) return;

    await BancoDeDados.instancia.inserirExercicio(
      widget.usuarioId,
      widget.dia,
      texto,
    );

    final atualizada = await BancoDeDados.instancia.pegarExerciciosDoDia(
      widget.usuarioId,
      widget.dia,
    );

    setState(() {
      lista = atualizada;
    });

    controller.clear();
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
        child: Column(
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Novo exercício",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: adicionar,
              child: const Text("ADICIONAR"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: Text(
                      lista[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
