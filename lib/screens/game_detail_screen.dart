import 'package:flutter/material.dart';
import '../models/game_model.dart';

class GameDetailScreen extends StatelessWidget {
  final GameModel jogo;

  const GameDetailScreen({
    super.key,
    required this.jogo,
  });

  Widget linha(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: ListTile(
          title: Text(titulo),
          subtitle: Text(valor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do jogo"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(
          children: [

            Card(
              child: Padding(
                padding: const EdgeInsets.all(25),

                child: Column(
                  children: [

                    jogo.imagem.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          jogo.imagem,
                          height: 160,
                          fit: BoxFit.cover,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return const Icon(
                              Icons.sports_esports,
                              size: 70,
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.sports_esports,
                        size: 70,
                      ),

                    const SizedBox(height: 10),

                    Text(
                      jogo.nome,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            linha(
              "Plataforma",
              jogo.plataforma,
            ),

            linha(
              "Categoria",
              jogo.categoria,
            ),

            linha(
              "Status",
              jogo.status,
            ),

            linha(
              "Raridade",
              jogo.raridade,
            ),

            linha(
              "Valor pago",
              "R\$ ${jogo.valorPago}",
            ),

            linha(
              "Valor estimado",
              "R\$ ${jogo.valorEstimado}",
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),

                label: const Text(
                  "Editar jogo",
                ),

                onPressed: () {

                  Navigator.pop(
                    context,
                    jogo,
                  );

                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}