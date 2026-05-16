import 'package:flutter/material.dart';
import 'models/game_model.dart';
import 'services/game_service.dart';
import 'screens/game_form_screen.dart';
import 'screens/game_detail_screen.dart';
import 'package:fl_chart/fl_chart.dart';

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

  String filtroStatus = "Todos";

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

  void aplicarFiltro(String status) {
    filtroStatus = status;

    atualizarFiltros();
  }

  void atualizarFiltros() {
    setState(() {

      jogosFiltrados = jogos.where((jogo) {

        final buscaOk = jogo.nome
            .toLowerCase()
            .contains(
              buscaController.text.toLowerCase(),
            );

        final statusOk =
            filtroStatus == "Todos"
            || jogo.status == filtroStatus;

        return buscaOk && statusOk;

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

  Future<void> abrirDetalhes(GameModel jogo) async {

    final jogoSelecionado =
        await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            GameDetailScreen(
          jogo: jogo,
        ),
      ),
    );

    if (jogoSelecionado != null) {
      editarJogo(
        jogoSelecionado,
      );
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

    final totalDesejos = jogos.where((jogo) {
      return jogo.status == "Lista de desejos";
    }).length;

    final totalEmprestados = jogos.where((jogo) {
      return jogo.status == "Emprestado";
    }).length;

    final totalVendidos = jogos.where((jogo) {
      return jogo.status == "Vendido";
    }).length;

  final totalTrocados = jogos.where((jogo) {
    return jogo.status == "Trocado";
  }).length;

  final totalColecao = jogos.where((jogo) {
    return jogo.status == "Na coleção";
  }).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("GameVault"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 4.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,

            children: [

              Card(
                child: Center(
                  child: ListTile(
                    leading: const Icon(Icons.sports_esports),
                    title: Text(jogos.length.toString()),
                    subtitle: const Text("Jogos"),
                  ),
                ),
              ),

              Card(
                child: Center(
                  child: ListTile(
                    leading: const Icon(Icons.attach_money),
                    title: Text(
                      "R\$ ${totalInvestido.toStringAsFixed(2)}",
                    ),
                    subtitle: const Text("Investido"),
                  ),
                ),
              ),

              Card(
                child: Center(
                  child: ListTile(
                    leading: const Icon(Icons.favorite),
                    title: Text(totalDesejos.toString()),
                    subtitle: const Text("Wishlist"),
                  ),
                ),
              ),

              Card(
                child: Center(
                  child: ListTile(
                    leading: const Icon(Icons.people),
                    title: Text(totalEmprestados.toString()),
                    subtitle: const Text("Emprestados"),
                  ),
                ),
              ),

              Card(
                child: Center(
                  child: ListTile(
                    leading: const Icon(Icons.sell),
                    title: Text(totalVendidos.toString()),
                    subtitle: const Text("Vendidos"),
                  ),
                ),
              ),

              Card(
                child: Center(
                  child: ListTile(
                    leading: const Icon(Icons.swap_horiz),
                    title: Text(totalTrocados.toString()),
                    subtitle: const Text("Trocados"),
                  ),
                ),
              ),

            ],
          ),

          SizedBox(
            height: 120,

            child: PieChart(

              PieChartData(

                centerSpaceRadius: 25,
                sectionsSpace: 3,

                sections: [

                  PieChartSectionData(
                    value: totalColecao.toDouble(),
                    title: totalColecao.toString(),
                    radius: 35,
                    color: Colors.green,
                  ),

                  PieChartSectionData(
                    value: totalDesejos.toDouble(),
                    title: totalDesejos.toString(),
                    radius: 35,
                    color: Colors.blue,
                  ),

                  PieChartSectionData(
                    value: totalEmprestados.toDouble(),
                    title: totalEmprestados.toString(),
                    radius: 35,
                    color: Colors.orange,
                  ),

                  PieChartSectionData(
                    value: totalVendidos.toDouble(),
                    title: totalVendidos.toString(),
                    radius: 35,
                    color: Colors.red,
                  ),

                  PieChartSectionData(
                    value: totalTrocados.toDouble(),
                    title: totalTrocados.toString(),
                    radius: 35,
                    color: Colors.purple,
                  ),
                ],
              )
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
              onChanged: (_) {
                atualizarFiltros();
              },
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: filtroStatus,

              decoration: const InputDecoration(
                labelText: "Filtrar por status",
                border: OutlineInputBorder(),
              ),

              items: const [

                DropdownMenuItem(
                  value: "Todos",
                  child: Text("Todos"),
                ),

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
              ],

              onChanged: (valor) {
                aplicarFiltro(valor!);
              },
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
                              abrirDetalhes(jogo);
                            },
                            leading: jogo.imagem.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  jogo.imagem,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (
                                    context,
                                    error,
                                    stackTrace,
                                  ) {
                                    return const Icon(
                                      Icons.sports_esports,
                                    );
                                  },
                                ),
                              )
                            : const Icon(
                                Icons.sports_esports,
                              ),
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