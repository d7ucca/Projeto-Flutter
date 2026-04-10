import 'package:flutter/material.dart';
import '../telalogin/mainlogin.dart';
import '../telacadastrar/maincadastrar.dart';

class TelaInicial extends StatelessWidget {
const TelaInicial({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white, // Fundo branco como no desenho
body: SafeArea(
child: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espalha os itens bem no estilo do seu layout
children: [

// 1. O círculo da Logo
Container(
width: 150,
height: 150,
decoration: BoxDecoration(
shape: BoxShape.circle,
border: Border.all(color: Colors.black, width: 3), // Borda preta grossa
),
child: const Center(
child: Text(
'logo',
style: TextStyle(fontSize: 20, color: Colors.black),
),
),
),

// 2. O botão de Login
ElevatedButton(
style: ElevatedButton.styleFrom(
minimumSize: const Size(250, 60), // Deixa o botão mais largo e alto
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15), // Bordas arredondadas
side: const BorderSide(color: Colors.black, width: 3), // Borda preta grossa
),
backgroundColor: Colors.white,
foregroundColor: Colors.black,
elevation: 0, // Tira a sombra pra ficar com cara de wireframe
),
onPressed: () {
// Aqui vai o código para ir para a tela de login depois
print('Botão Login pressionado');
},
child: const Text(
'login',
style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
),

// 3. O texto de Cadastro
TextButton(
onPressed: () {
// Aqui vai o código para ir para a tela de cadastro depois
print('Texto Cadastre-se pressionado');
},
child: const Text(
'não tem uma conta? cadastre-se',
style: TextStyle(
color: Colors.black,
fontSize: 16,
decoration: TextDecoration.underline, // Linha embaixo do texto
),
),
),

],
),
),
),
);
}
}

