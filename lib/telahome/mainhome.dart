import 'package:flutter/material.dart';

// ==========================================
// 1. TELA HOME
// ==========================================
class TelaHome extends StatelessWidget {
const TelaHome({super.key});

List<String> _pegarExerciciosDoDia(String dia) {
if (dia == 'segunda') return ['ex 1', 'ex 2', 'ex 3', 'ex 4'];
if (dia == 'terca') return ['ex 1', 'ex 2', 'ex 3'];
if (dia == 'quarta') return ['ex 1', 'ex 2'];
if (dia == 'quinta') return ['ex 1', 'ex 2', 'ex 3', 'ex 4', 'ex 5'];
if (dia == 'sexta') return ['ex 1', 'ex 2', 'ex 3'];
if (dia == 'sabado') return ['Caminhada', 'Alongamento'];
if (dia == 'domingo') return ['Descanso total'];
return [];
}

@override
Widget build(BuildContext context) {
final List<String> diasDaSemana = [
'segunda', 'terca', 'quarta', 'quinta', 'sexta', 'sabado', 'domingo'
];

return Scaffold(
backgroundColor: Colors.white,
appBar: AppBar(
backgroundColor: Colors.white,
elevation: 0,
iconTheme: const IconThemeData(color: Colors.black),
),
body: SafeArea(
child: SingleChildScrollView(
padding: const EdgeInsets.symmetric(horizontal: 40),
child: Column(
children: [
Container(
width: 120, height: 120,
decoration: BoxDecoration(
shape: BoxShape.circle,
border: Border.all(color: Colors.black, width: 3),
),
child: const Center(child: Text('logo', style: TextStyle(fontSize: 18))),
),
const SizedBox(height: 20),
const Text('treinos', style: TextStyle(fontSize: 18, color: Colors.black)),
const SizedBox(height: 30),
...diasDaSemana.map((dia) => _botaoDia(context, dia)).toList(),
const SizedBox(height: 20),
],
),
),
),
);
}

Widget _botaoDia(BuildContext context, String texto) {
return Padding(
padding: const EdgeInsets.only(bottom: 15.0),
child: ElevatedButton(
style: ElevatedButton.styleFrom(
minimumSize: const Size(double.infinity, 50),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15),
side: const BorderSide(color: Colors.black, width: 3),
),
backgroundColor: Colors.white,
foregroundColor: Colors.black,
elevation: 0,
alignment: Alignment.centerLeft,
padding: const EdgeInsets.symmetric(horizontal: 20),
),
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => TelaDiaSemana(
nomeDoDia: texto,
exercicios: _pegarExerciciosDoDia(texto),
),
),
);
},
child: Text(texto, style: const TextStyle(fontSize: 16)),
),
);
}
}

// ==========================================
// 2. TELA DIA DA SEMANA (EMBUTIDA AQUI)
// ==========================================
class TelaDiaSemana extends StatelessWidget {
final String nomeDoDia;
final List<String> exercicios;

const TelaDiaSemana({
super.key,
required this.nomeDoDia,
required this.exercicios,
});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
appBar: AppBar(
backgroundColor: Colors.white,
elevation: 0,
iconTheme: const IconThemeData(color: Colors.black),
),
body: SafeArea(
child: SingleChildScrollView(
padding: const EdgeInsets.symmetric(horizontal: 40),
child: Column(
children: [
Container(
width: 120, height: 120,
decoration: BoxDecoration(
shape: BoxShape.circle,
border: Border.all(color: Colors.black, width: 3),
),
child: const Center(child: Text('logo', style: TextStyle(fontSize: 18))),
),
const SizedBox(height: 20),
Text(nomeDoDia, style: const TextStyle(fontSize: 18, color: Colors.black)),
const SizedBox(height: 30),
...exercicios.map((ex) => _caixaExercicio(ex)).toList(),
const SizedBox(height: 30),
_botaoAcao('proximo', () { print('Botão próximo pressionado'); }),
const SizedBox(height: 15),
_botaoAcao('voltar', () { Navigator.pop(context); }),
const SizedBox(height: 20),
],
),
),
),
);
}

Widget _caixaExercicio(String texto) {
return Padding(
padding: const EdgeInsets.only(bottom: 15.0),
child: Container(
width: double.infinity,
padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(15),
border: Border.all(color: Colors.black, width: 3),
),
child: Text(texto, style: const TextStyle(fontSize: 16, color: Colors.black)),
),
);
}

Widget _botaoAcao(String texto, VoidCallback aoPressionar) {
return ElevatedButton(
style: ElevatedButton.styleFrom(
minimumSize: const Size(double.infinity, 50),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15),
side: const BorderSide(color: Colors.black, width: 3),
),
backgroundColor: Colors.white,
foregroundColor: Colors.black,
elevation: 0,
),
onPressed: aoPressionar,
child: Text(texto, style: const TextStyle(fontSize: 16)),
);
}
}