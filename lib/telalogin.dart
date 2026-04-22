import 'package:flutter/material.dart';
import 'telahome.dart';

// 1. Mudamos para StatefulWidget porque agora a tela tem lógica e "vida"
class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  // 2. Criando os "Espiões" que vão capturar o que o usuário digitar
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Container(
                width: 120, height: 120,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 3)),
                child: const Center(child: Text('logo', style: TextStyle(fontSize: 18, color: Colors.black))),
              ),
              const SizedBox(height: 20),
              const Text('login', style: TextStyle(fontSize: 18, color: Colors.black)),
              const SizedBox(height: 30),
              
              // 3. Passando os espiões para as caixinhas de texto
              _campoTexto('e-mail', controller: _emailController),
              const SizedBox(height: 15),
              
              _campoTexto('senha', isSenha: true, controller: _senhaController),
              const SizedBox(height: 40),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: const BorderSide(color: Colors.black, width: 3)),
                  backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0,
                ),
                onPressed: () {
                  // 4. A HORA DA VERDADE: Lendo o que foi digitado
                  String emailDigitado = _emailController.text;
                  String senhaDigitada = _senhaController.text;

                  // O nosso "banco de dados" fake para testar
                  if (emailDigitado == 'luis' && senhaDigitada == '123') {
                    // Acertou! Vai pra Home
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TelaHome()));
                  } else {
                    // Errou! Mostra o aviso vermelho de erro
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('E-mail ou senha incorretos!', style: TextStyle(color: Colors.white, fontSize: 16)),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: const Text('entrar', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- MOLDE DOS CAMPOS DE TEXTO (Agora ele aceita o controller!) ---
  Widget _campoTexto(String texto, {bool isSenha = false, required TextEditingController controller}) {
    return TextField(
      controller: controller, // Ligando o espião na caixinha
      obscureText: isSenha,
      decoration: InputDecoration(
        hintText: texto,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.black, width: 3)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.black, width: 3)),
      ),
    );
  }
}