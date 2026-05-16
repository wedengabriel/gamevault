import 'package:flutter/material.dart';
import '../models/game_model.dart';

class GameFormScreen extends StatefulWidget {
  final GameModel? game;

  const GameFormScreen({
    super.key,
    this.game,
  });

  @override
  State<GameFormScreen> createState() => _GameFormScreenState();
}

class _GameFormScreenState extends State<GameFormScreen> {
  final nomeController = TextEditingController();
  final plataformaController = TextEditingController();
  final categoriaController = TextEditingController();
  final valorPagoController = TextEditingController();
  final valorEstimadoController = TextEditingController();
  final imagemController = TextEditingController();
  
  String status = "Na coleção";
  String raridade = "Comum";

  @override
  void initState() {
    super.initState();

    if (widget.game != null) {
      nomeController.text = widget.game!.nome;
      plataformaController.text = widget.game!.plataforma;
      categoriaController.text = widget.game!.categoria;
      status = widget.game!.status;
      raridade = widget.game!.raridade;
      valorPagoController.text = widget.game!.valorPago.toString();
      valorEstimadoController.text = widget.game!.valorEstimado.toString();
      imagemController.text = widget.game!.imagem;
    }
  }

  void salvar() {
    final jogo = GameModel(
      id: widget.game?.id,
      nome: nomeController.text,
      plataforma: plataformaController.text,
      categoria: categoriaController.text,
      status: status,
      raridade: raridade,
      valorPago: double.tryParse(valorPagoController.text) ?? 0,
      valorEstimado: double.tryParse(valorEstimadoController.text) ?? 0,
      localizacao: widget.game?.localizacao ?? "",
      observacoes: widget.game?.observacoes ?? "",
      imagem: imagemController.text,
    );

    Navigator.pop(context, jogo);
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.game != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? "Editar jogo" : "Cadastrar jogo"),
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

              TextField(
                controller: imagemController,
                decoration: const InputDecoration(
                  labelText: "URL da capa",
                  hintText: "https://...",
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: valorPagoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Valor pago",
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: valorEstimadoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Valor estimado",
                ),
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: status,
                decoration: const InputDecoration(
                  labelText: "Status",
                ),
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
                  DropdownMenuItem(
                    value: "Vendido",
                    child: Text("Vendido"),
                  ),
                  DropdownMenuItem(
                    value: "Trocado",
                    child: Text("Trocado"),
                  ),
                  DropdownMenuItem(
                    value: "Repetido",
                    child: Text("Repetido"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    status = value!;
                  });
                },
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: raridade,
                decoration: const InputDecoration(
                  labelText: "Raridade",
                ),
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
                  onPressed: salvar,
                  child: Text(editando ? "Salvar alterações" : "Salvar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}