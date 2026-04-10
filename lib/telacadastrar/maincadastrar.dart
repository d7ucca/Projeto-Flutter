import 'package:flutter/material.dart';
import '../telahome/mainhome.dart';

class TelaCadastro extends StatelessWidget {
const TelaCadastro({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
// AppBar adiciona a setinha de voltar automaticamente no topo
appBar: AppBar(
backgroundColor: Colors.white,
elevation: 0,
iconTheme: const IconThemeData(color: Colors.black),
),
body: SafeArea(
child: SingleChildScrollView( // Permite rolar a tela se o teclado aparecer
padding: const EdgeInsets.symmetric(horizontal: 40), // Espaço nas laterais
child: Column(
children: [

// 1. O círculo da Logo
Container(
width: 120,
height: 120,
decoration: BoxDecoration(
shape: BoxShape.circle,
border: Border.all(color: Colors.black, width: 3),
),
child: const Center(
child: Text(
'logo',
style: TextStyle(fontSize: 18, color: Colors.black),
),
),
),
const SizedBox(height: 20), // Dá um espacinho entre os elementos

// 2. Título
const Text(
'cadastre-se',
style: TextStyle(fontSize: 18, color: Colors.black),
),
const SizedBox(height: 30),

// 3. Campos de Texto (usando o molde que criamos lá embaixo)
_campoTexto('Nome'),
const SizedBox(height: 15),

_campoTexto('E-mail'),
const SizedBox(height: 15),

_campoTexto('Senha', isSenha: true), // Este esconde o que é digitado
const SizedBox(height: 40),

// 4. Botão Cadastrar
ElevatedButton(
style: ElevatedButton.styleFrom(
minimumSize: const Size(double.infinity, 60), // double.infinity faz esticar até o limite das laterais
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15),
side: const BorderSide(color: Colors.black, width: 3),
),
backgroundColor: Colors.white,
foregroundColor: Colors.black,
elevation: 0,
),
onPressed: () {
print('Botão Cadastrar pressionado');
},
child: const Text(
'cadastrar',
style: TextStyle(fontSize: 18),
),
),
const SizedBox(height: 20),
],
),
),
),
);
}

// --- MOLDE DOS CAMPOS DE TEXTO ---
// Isso evita que a gente tenha que copiar e colar o mesmo código 3 vezes
Widget _campoTexto(String texto, {bool isSenha = false}) {
return TextField(
obscureText: isSenha, // Se for senha, esconde os caracteres com bolinhas
decoration: InputDecoration(
hintText: texto, // O texto que fica apagadinho dentro do campo
contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

// Bordas quando não está selecionado
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(15),
borderSide: const BorderSide(color: Colors.black, width: 3),
),

// Bordas quando você clica para digitar
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(15),
borderSide: const BorderSide(color: Colors.black, width: 3),
),
),
);
}
}
