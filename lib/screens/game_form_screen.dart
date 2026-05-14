import 'package:flutter/material.dart';
import '../models/game_model.dart';

class GameFormScreen extends StatefulWidget {
  const GameFormScreen({super.key});

  @override
  State<GameFormScreen> createState() => _GameFormScreenState();
}

class _GameFormScreenState extends State<GameFormScreen> {
  final nomeController = TextEditingController();
  final plataformaController = TextEditingController();
  final categoriaController = TextEditingController();

  String status = "Na coleção";
  String raridade = "Comum";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar jogo"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(
          child: Column(
            children: [

              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome do jogo",
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: plataformaController,
                decoration: const InputDecoration(
                  labelText: "Plataforma",
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: categoriaController,
                decoration: const InputDecoration(
                  labelText: "Categoria",
                ),
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField(
                value: status,
                items: const [
                  DropdownMenuItem(
                    value: "Na coleção",
                    child: Text("Na coleção"),
                  ),
                  DropdownMenuItem(
                    value: "Lista de desejos",
                    child: Text("Lista de desejos"),
                  ),
                  DropdownMenuItem(
                    value: "Emprestado",
                    child: Text("Emprestado"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    status = value!;
                  });
                },
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField(
                value: raridade,
                items: const [
                  DropdownMenuItem(
                    value: "Comum",
                    child: Text("Comum"),
                  ),
                  DropdownMenuItem(
                    value: "Raro",
                    child: Text("Raro"),
                  ),
                  DropdownMenuItem(
                    value: "Lendário",
                    child: Text("Lendário"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    raridade = value!;
                  });
                },
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                    final jogo = GameModel(
                      nome: nomeController.text,
                      plataforma: plataformaController.text,
                      categoria: categoriaController.text,
                      status: status,
                      raridade: raridade,
                      valorPago: 0,
                      valorEstimado: 0,
                      localizacao: "",
                      observacoes: "",
                      imagem: "",
                    );

                    Navigator.pop(context, jogo);
                  },
                  child: const Text("Salvar"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}