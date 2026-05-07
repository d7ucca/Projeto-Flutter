import 'package:flutter/material.dart';
import 'telahome.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2EFE2E)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Image.asset('assets/imagem.jpg', width: 150, height: 150),
              const SizedBox(height: 10),
              const Text(
                'LOGIN GYMD10',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 2),
              ),
              const SizedBox(height: 40),
              _campoTexto('E-MAIL', controller: _emailController),
              const SizedBox(height: 20),
              _campoTexto('SENHA', isSenha: true, controller: _senhaController),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: const Color(0xFF2EFE2E),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 8,
                ),
                onPressed: () {
                  String email = _emailController.text;
                  String senha = _senhaController.text;
                  if (email == 'luis' && senha == '123') {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TelaHome()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('USUÁRIO OU SENHA INVÁLIDOS!', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.redAccent),
                    );
                  }
                },
                child: const Text('ACESSAR TREINOS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campoTexto(String texto, {bool isSenha = false, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: isSenha,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: texto,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.grey, width: 1)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Color(0xFF2EFE2E), width: 2)),
      ),
    );
  }
}