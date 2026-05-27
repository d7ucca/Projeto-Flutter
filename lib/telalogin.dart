import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'telahome.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final AuthService _authService = AuthService();

  bool _isLoading = false;

  Future<void> fazerLogin() async {
    setState(() => _isLoading = true);

    try {
      final auth = await _authService.login(
        _usuarioController.text.trim(),
        _senhaController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TelaHome(usuarioId: auth.userId, nome: auth.name),
        ),
      );
    } catch (e) {
      mostrarErro(e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void mostrarErro(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            TextField(
              controller: _usuarioController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Usuário",
                filled: true,
                fillColor: Color(0xFF1E1E1E),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _senhaController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Senha",
                filled: true,
                fillColor: Color(0xFF1E1E1E),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : fazerLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2EFE2E),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text("ENTRAR"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
