import 'package:flutter/material.dart';
import 'banco.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  int _abaSelecionada = 0; 

  final List<String> diasDaSemana = [
    'segunda', 'terca', 'quarta', 'quinta', 'sexta', 'sabado', 'domingo'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'MEUS TREINOS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
      body: _abaSelecionada == 0 
          ? _construirAbaTreinos(context) 
          : const Center(
              child: Text('Em construção 🚧', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _abaSelecionada,
        onTap: (index) {
          setState(() {
            _abaSelecionada = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progresso'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  Widget _construirAbaTreinos(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 3)),
              child: const Center(child: Text('LOGO')),
            ),
            const SizedBox(height: 30),
            ...diasDaSemana.map((dia) => _botaoDia(context, dia)).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _botaoDia(BuildContext context, String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: const BorderSide(color: Colors.black, width: 3)),
          backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0, alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        onPressed: () async {
          List<String> exerciciosDoBanco = await BancoDeDados.instancia.pegarExerciciosDoDia(texto);
          if (exerciciosDoBanco.isEmpty) {
            await BancoDeDados.instancia.inserirExercicio(texto, 'Exercício 01 - $texto');
            await BancoDeDados.instancia.inserirExercicio(texto, 'Exercício 02 - $texto');
            exerciciosDoBanco = await BancoDeDados.instancia.pegarExerciciosDoDia(texto);
          }
          if (!context.mounted) return;
          Navigator.push(context, MaterialPageRoute(builder: (context) => TelaDiaSemana(nomeDoDia: texto, exercicios: exerciciosDoBanco)));
        },
        child: Text(texto.toUpperCase(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(nomeDoDia.toUpperCase(), style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: exercicios.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.black, width: 2)),
                    child: Text(exercicios[index], style: const TextStyle(fontSize: 16)),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 50)),
              onPressed: () => Navigator.pop(context),
              child: const Text('VOLTAR'),
            ),
          ],
        ),
      ),
    );
  }
}