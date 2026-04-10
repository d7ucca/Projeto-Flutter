import 'package:flutter/material.dart';
import '../telahome/mainhome.dart';

class TelaLogin extends StatelessWidget {
const TelaLogin({super.key});

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
const SizedBox(height: 20),

// 2. Título
const Text(
'login',
style: TextStyle(fontSize: 18, color: Colors.black),
),
const SizedBox(height: 30),

// 3. Campos de Texto
_campoTexto('e-mail'),
const SizedBox(height: 15),

_campoTexto('senha', isSenha: true),
const SizedBox(height: 40),

// 4. Botão Entrar
ElevatedButton(
style: ElevatedButton.styleFrom(
minimumSize: const Size(double.infinity, 60),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15),
side: const BorderSide(color: Colors.black, width: 3),
),
backgroundColor: Colors.white,
foregroundColor: Colors.black,
elevation: 0,
),
onPressed: () {
print('Botão Entrar pressionado');
},
child: const Text(
'entrar',
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
Widget _campoTexto(String texto, {bool isSenha = false}) {
return TextField(
obscureText: isSenha,
decoration: InputDecoration(
hintText: texto,
contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(15),
borderSide: const BorderSide(color: Colors.black, width: 3),
),
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(15),
borderSide: const BorderSide(color: Colors.black, width: 3),
),
),
);
}
}
