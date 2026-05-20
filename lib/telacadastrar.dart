import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'telahome.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() =>
      _TelaCadastroState();
}

class _TelaCadastroState
    extends State<TelaCadastro> {
  final TextEditingController
      _nomeController =
      TextEditingController();

  final TextEditingController
      _sobrenomeController =
      TextEditingController();

  final TextEditingController
      _emailController =
      TextEditingController();

  final TextEditingController
      _usuarioController =
      TextEditingController();

  final TextEditingController
      _senhaController =
      TextEditingController();

  bool _isLoading = false;

  Future<void> cadastrar() async {
    setState(() {
      _isLoading = true;
    });

    final nome =
        _nomeController.text.trim();

    final sobrenome =
        _sobrenomeController.text.trim();

    final email =
        _emailController.text.trim();

    final usuario =
        _usuarioController.text.trim();

    final senha =
        _senhaController.text.trim();

    final url = Uri.parse(
      'https://mobile-ios-login.zani0x03.eti.br/api/register',
    );

    try {
      final response = await http.post(
        url,

        headers: {
          'Content-Type':
              'application/json',
        },

        body: jsonEncode({
          "name": nome,
          "surname": sobrenome,
          "login": usuario,
          "email": email,
          "password": senha,
          "sistemaId":
              "95a33e96-3357-4d83-b2ec-4d1da3e2fc07
              "
        }),
      );

      print(
          "STATUS: ${response.statusCode}");

      print("BODY: ${response.body}");

      if (!mounted) return;

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const TelaHome(),
          ),
        );
      } else {
        mostrarErro(response.body);
      }
    } catch (e) {
      print("ERRO: $e");

      mostrarErro(
        "Erro de conexão com a API",
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void mostrarErro(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor:
            Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        elevation: 0,

        iconTheme:
            const IconThemeData(
          color: Color(0xFF2EFE2E),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 40,
          ),

          child: Column(
            children: [
              Image.asset(
                'assets/imagem.jpg',
                width: 120,
                height: 120,
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                'NOVO MEMBRO GYMD10',

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight:
                      FontWeight.w900,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              _campoTexto(
                'NOME',
                controller:
                    _nomeController,
              ),

              const SizedBox(
                height: 15,
              ),

              _campoTexto(
                'SOBRENOME',
                controller:
                    _sobrenomeController,
              ),

              const SizedBox(
                height: 15,
              ),

              _campoTexto(
                'EMAIL',
                controller:
                    _emailController,
              ),

              const SizedBox(
                height: 15,
              ),

              _campoTexto(
                'USUÁRIO',
                controller:
                    _usuarioController,
              ),

              const SizedBox(
                height: 15,
              ),

              _campoTexto(
                'SENHA',
                isSenha: true,
                controller:
                    _senhaController,
              ),

              const SizedBox(
                height: 40,
              ),

              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  minimumSize:
                      const Size(
                    double.infinity,
                    60,
                  ),

                  backgroundColor:
                      const Color(
                    0xFF2EFE2E,
                  ),

                  foregroundColor:
                      Colors.black,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius
                            .circular(
                      15,
                    ),
                  ),
                ),

                onPressed:
                    _isLoading
                        ? null
                        : cadastrar,

                child: _isLoading
                    ? const CircularProgressIndicator(
                        color:
                            Colors.black,
                      )
                    : const Text(
                        'FINALIZAR MATRÍCULA',

                        style:
                            TextStyle(
                          fontWeight:
                              FontWeight
                                  .bold,
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
    required TextEditingController
        controller,
  }) {
    return TextField(
      controller: controller,

      obscureText: isSenha,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(
        hintText: texto,

        hintStyle:
            const TextStyle(
          color: Colors.grey,
        ),

        filled: true,

        fillColor:
            const Color(0xFF1E1E1E),

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            15,
          ),
        ),
      ),
    );
  }
}