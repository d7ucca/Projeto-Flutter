import 'package:flutter/material.dart';
import 'telahome.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {

  final TextEditingController _nomeController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _senhaController =
      TextEditingController();

  Future<void> cadastrarUsuario() async {

    final url = Uri.parse(
      'https://mobile-ios-login.zani0x03.eti.br/api/register',
    );

    try {

      final response = await http.post(
        url,

        headers: {
          'Content-Type': 'application/json',
        },

        body: jsonEncode({

          "name": _nomeController.text.trim(),

          "surname": "usuario",

          "login": _emailController.text.trim(),

          "email": _emailController.text.trim(),

          "password": _senhaController.text.trim(),

          "sistemaId":
              "395bde7f-d6fc-4432-b227-025289547c71"
        }),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Usuário cadastrado com sucesso',
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TelaHome(),
          ),
        );

      } else {

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erro: ${response.body}',
            ),
          ),
        );
      }

    } catch (e) {

      print(e);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro de conexão: $e',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
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

          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),

          child: Column(

            children: [

              Image.asset(
                'assets/imagem.jpg',
                width: 120,
                height: 120,
              ),

              const SizedBox(height: 10),

              const Text(
                'NOVO MEMBRO GYMD10',

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              _campoTexto(
                'NOME COMPLETO',
                controller: _nomeController,
              ),

              const SizedBox(height: 15),

              _campoTexto(
                'E-MAIL',
                controller: _emailController,
              ),

              const SizedBox(height: 15),

              _campoTexto(
                'CRIAR SENHA',
                isSenha: true,
                controller: _senhaController,
              ),

              const SizedBox(height: 40),

              ElevatedButton(

                style: ElevatedButton.styleFrom(

                  minimumSize:
                      const Size(double.infinity, 60),

                  backgroundColor:
                      const Color(0xFF2EFE2E),

                  foregroundColor: Colors.black,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),

                  elevation: 8,
                ),

                onPressed: cadastrarUsuario,

                child: const Text(
                  'FINALIZAR MATRÍCULA',

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 20),
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
          fontSize: 14,
        ),

        filled: true,

        fillColor: const Color(0xFF1E1E1E),

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),

        enabledBorder: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(15),

          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(15),

          borderSide: const BorderSide(
            color: Color(0xFF2EFE2E),
            width: 2,
          ),
        ),
      ),
    );
  }
}