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
  List<GameModel> jogosFiltrados = [];

  final buscaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarJogos();
  }

  Future<void> carregarJogos() async {
    jogos = await service.getGames();
    jogosFiltrados = List.from(jogos);

    setState(() {});
  }

  void filtrarJogos(String texto) {
    setState(() {
      jogosFiltrados = jogos.where((jogo) {
        return jogo.nome.toLowerCase().contains(texto.toLowerCase());
      }).toList();
    });
  }

  Future<void> excluirJogo(int id) async {
    await service.deleteGame(id);
    carregarJogos();
  }

Future<void> editarJogo(GameModel jogo) async {

  final jogoEditado = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => GameFormScreen(
        game: jogo,
      ),
    ),
  );

  if (jogoEditado != null) {
    await service.updateGame(jogoEditado);

    carregarJogos();
  }
}

  Future<void> abrirCadastro() async {
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
  }

  @override
  Widget build(BuildContext context) {
    final totalInvestido = jogos.fold<double>(
      0,
      (total, jogo) => total + jogo.valorPago,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("GameVault"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          jogos.length.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text("Jogos"),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "R\$ ${totalInvestido.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text("Investido"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: buscaController,
              decoration: const InputDecoration(
                hintText: "Buscar jogo...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: filtrarJogos,
            ),

            const SizedBox(height: 12),

            Expanded(
              child: jogosFiltrados.isEmpty
                  ? const Center(
                      child: Text("Nenhum jogo encontrado"),
                    )
                  : ListView.builder(
                      itemCount: jogosFiltrados.length,
                      itemBuilder: (context, index) {
                        final jogo = jogosFiltrados[index];

                        return Card(
                          child: ListTile(
                            onTap: () {
                              editarJogo(jogo);
                            },
                            leading: const Icon(Icons.sports_esports),
                            title: Text(jogo.nome),
                            subtitle: Text(
                              "${jogo.plataforma} • ${jogo.status}",
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                excluirJogo(jogo.id!);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: abrirCadastro,
        child: const Icon(Icons.add),
      ),
    );
  }
}