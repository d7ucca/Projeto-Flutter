import 'package:flutter/material.dart';
import 'banco.dart';
import 'telainicial.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  final List<String> diasDaSemana = [
    'segunda', 'terca', 'quarta', 'quinta', 'sexta', 'sabado', 'domingo'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, // Tira a setinha de voltar
        title: const Text(
          'MEUS TREINOS',
          style: TextStyle(
            color: Color(0xFF2EFE2E), 
            fontWeight: FontWeight.w900, 
            letterSpacing: 3
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/imagem.jpg', width: 120, height: 120),
              const SizedBox(height: 30),
              ...diasDaSemana.map((dia) => _botaoDia(context, dia)).toList(),
              const SizedBox(height: 30),
              
              // BOTÃO DE SAIR NO FINAL DA LISTA
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  side: const BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaInicial()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.redAccent),
                label: const Text('SAIR DA ACADEMIA', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _botaoDia(BuildContext context, String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 60),
          backgroundColor: const Color(0xFF1E1E1E),
          foregroundColor: const Color(0xFF2EFE2E),
          elevation: 0,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFF333333), width: 1),
          ),
        ),
        onPressed: () async {
          List<String> exerciciosDoBanco = await BancoDeDados.instancia.pegarExerciciosDoDia(texto);
          if (exerciciosDoBanco.isEmpty) {
            await BancoDeDados.instancia.inserirExercicio(texto, 'SUPINO RETO - 4x10');
            await BancoDeDados.instancia.inserirExercicio(texto, 'AGACHAMENTO LIVRE - 3x12');
            exerciciosDoBanco = await BancoDeDados.instancia.pegarExerciciosDoDia(texto);
          }
          if (!mounted) return;
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => TelaDiaSemana(nomeDoDia: texto, exercicios: exerciciosDoBanco)
            )
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              texto.toUpperCase(), 
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.2)
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}

class TelaDiaSemana extends StatelessWidget {
  final String nomeDoDia;
  final List<String> exercicios; 

  const TelaDiaSemana({super.key, required this.nomeDoDia, required this.exercicios});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2EFE2E)),
        title: Text(
          nomeDoDia.toUpperCase(), 
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: exercicios.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFF2EFE2E).withOpacity(0.3), width: 1),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_outline, color: Color(0xFF2EFE2E)),
                        const SizedBox(width: 15),
                        Text(
                          exercicios[index], 
                          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2EFE2E),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('VOLTAR AOS DIAS', style: TextStyle(fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
    );
  }
}