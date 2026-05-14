import 'package:flutter/material.dart';
import 'models/game_model.dart';
import 'services/game_service.dart';
import 'screens/game_form_screen.dart';

void main() {
  runApp(const GameVaultApp());
}

class GameVaultApp extends StatelessWidget {
  const GameVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GameVault',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GameService service = GameService();

  List<GameModel> jogos = [];

  @override
  void initState() {
    super.initState();
    carregarJogos();
  }

  Future<void> carregarJogos() async {
    jogos = await service.getGames();

    setState(() {});
  }

  Future<void> adicionarExemplo() async {
    await service.addGame(
      GameModel(
        nome: "God Of War",
        plataforma: "PlayStation",
        categoria: "Ação",
        status: "Na coleção",
        raridade: "Raro",
        valorPago: 199.90,
        valorEstimado: 250,
        localizacao: "Estante",
        observacoes: "Versão mídia física",
        imagem: "",
      ),
    );

    carregarJogos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GameVault"),
        centerTitle: true,
      ),

      body: jogos.isEmpty
          ? const Center(
              child: Text("Nenhum jogo cadastrado"),
            )
          : ListView.builder(
              itemCount: jogos.length,
              itemBuilder: (context, index) {
                final jogo = jogos[index];

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.sports_esports),
                    title: Text(jogo.nome),
                    subtitle: Text(
                      "${jogo.plataforma} • ${jogo.status}",
                    ),
                    trailing: Text(
                      "R\$ ${jogo.valorPago}",
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          final jogo = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const GameFormScreen(),
            ),
          );

          if (jogo != null) {
            await service.addGame(jogo);

            carregarJogos();
          }
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}