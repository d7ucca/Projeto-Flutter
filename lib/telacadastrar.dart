import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'telahome.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  bool _isLoading = false;

  Future<void> cadastrar() async {
    setState(() => _isLoading = true);

    final url = Uri.parse(
      'https://mobile-ios-login.zani0x03.eti.br/api/register',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": _nomeController.text.trim(),
          "surname": _sobrenomeController.text.trim(),
          "login": _usuarioController.text.trim(),
          "email": _emailController.text.trim(),
          "password": _senhaController.text.trim(),
          "sistemaId": "95a33e96-3357-4d83-b2ec-4d1da3e2fc07",
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        final String usuarioId = data["id"];
        final String nome = data["name"] ?? "";

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TelaHome(usuarioId: usuarioId, nome: nome),
          ),
        );
      } else {
        mostrarErro(response.body);
      }
    } catch (e) {
      mostrarErro("Erro de conexão com a API");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void mostrarErro(String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _campo("Nome", _nomeController),
          _campo("Sobrenome", _sobrenomeController),
          _campo("Email", _emailController),
          _campo("Usuário", _usuarioController),
          _campo("Senha", _senhaController, senha: true),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: _isLoading ? null : cadastrar,
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text("CADASTRAR"),
          ),
        ],
      ),
    );
  }

  Widget _campo(String label, TextEditingController c, {bool senha = false}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: c,
        obscureText: senha,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: label,
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
        ),
      ),
    );
  }
}
