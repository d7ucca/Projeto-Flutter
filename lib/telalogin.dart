import 'package:flutter/material.dart';
import 'telahome.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  Future<void> fazerLogin() async {
    String username = _emailController.text.trim();
    String password = _senhaController.text.trim();

    final url = Uri.parse(
      'https://mobile-ios-login.zani0x03.eti.br/api/auth/login',
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "username": username,
          "password": password,
          "sistemaId": "395bde7f-d6fc-4432-b227-025289547c71"
        }),
      );

      // DEBUG
      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TelaHome(),
          ),
        );
      } else {
        mostrarErro('Usuário ou senha inválidos');
      }
    } catch (e) {
      print("ERRO: $e");
      mostrarErro('Erro de conexão com a API');
    }
  }

  void mostrarErro(String msg) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF2EFE2E),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),

          child: Column(
            children: [
              Image.asset(
                'assets/imagem.jpg',
                width: 150,
                height: 150,
              ),

              const SizedBox(height: 10),

              const Text(
                'LOGIN GYMD10',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 40),

              _campoTexto(
                'USUÁRIO',
                controller: _emailController,
              ),

              const SizedBox(height: 20),

              _campoTexto(
                'SENHA',
                isSenha: true,
                controller: _senhaController,
              ),

              const SizedBox(height: 50),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    60,
                  ),

                  backgroundColor: const Color(0xFF2EFE2E),
                  foregroundColor: Colors.black,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  elevation: 8,
                ),

                onPressed: fazerLogin,

                child: const Text(
                  'ACESSAR TREINOS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campoTexto(
    String texto, {
    bool isSenha = false,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isSenha,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(
        hintText: texto,

        hintStyle: const TextStyle(
          color: Colors.grey,
        ),

        filled: true,
        fillColor: const Color(0xFF1E1E1E),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),

          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),

          borderSide: const BorderSide(
            color: Color(0xFF2EFE2E),
            width: 2,
          ),
        ),
      ),
    );
  }
}