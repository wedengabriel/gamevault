import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobre"),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.sports_esports,
                size: 100,
              ),

              const SizedBox(height: 20),

              const Text(
                "GameVault",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Sistema de gerenciamento de coleção de jogos",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              const Divider(),

              const SizedBox(height: 20),

              const Text(
                "Desenvolvido por:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                "Weden Gabriel",
              ),

              const Text(
                "RU: 4170826",
              ),

              const SizedBox(height: 20),

              const Text(
                "Análise e Desenvolvimento de Sistemas",
              ),

              const Text(
                "UNINTER",
              ),

              const SizedBox(height: 20),

              const Text(
                "Versão 1.0 • 2026",
              ),
            ],
          ),
        ),
      ),
    );
  }
}