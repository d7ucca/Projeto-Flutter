import 'package:flutter/material.dart';
import 'telalogin.dart';
import 'telacadastrar.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), 
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/imagem.jpg', width: 280, height: 280),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 65),
                      backgroundColor: const Color(0xFF2EFE2E),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      elevation: 10,
                      shadowColor: const Color(0xFF2EFE2E).withOpacity(0.5),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaLogin()));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaCadastro()));
                    },
                    child: const Text(
                      'Ainda não tem uma conta? Cadastre-se',
                      style: TextStyle(
                        color: Color(0xFF2EFE2E), fontSize: 14, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}