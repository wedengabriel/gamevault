import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/game_model.dart';

class ReportScreen extends StatelessWidget {
  final List<GameModel> jogos;

  const ReportScreen({
    super.key,
    required this.jogos,
  });

  @override
  Widget build(BuildContext context) {

    final totalColecao = jogos.where(
      (j) => j.status == "Na coleção",
    ).length;

    final totalDesejos = jogos.where(
      (j) => j.status == "Lista de desejos",
    ).length;

    final totalEmprestados = jogos.where(
      (j) => j.status == "Emprestado",
    ).length;

    final totalVendidos = jogos.where(
      (j) => j.status == "Vendido",
    ).length;

    final totalTrocados = jogos.where(
      (j) => j.status == "Trocado",
    ).length;

    final totalInvestido =
        jogos.fold<double>(
      0,
      (total, jogo) =>
          total + jogo.valorPago,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Relatórios",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(

          children: [

            const Text(
              "Distribuição da coleção",
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 250,

              child: PieChart(
                PieChartData(

                  centerSpaceRadius:
                      45,

                  sectionsSpace: 3,

                  sections: [

                    PieChartSectionData(
                      value: totalColecao.toDouble(),
                      title: "Coleção\n$totalColecao",
                      color: Colors.green,
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    PieChartSectionData(
                      value: totalDesejos.toDouble(),
                      title: "Wish\n$totalDesejos",
                      color: Colors.blue,
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    PieChartSectionData(
                      value: totalEmprestados.toDouble(),
                      title: "Emp.\n$totalEmprestados",
                      color: Colors.orange,
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    PieChartSectionData(
                      value: totalVendidos.toDouble(),
                      title: "Vend.\n$totalVendidos",
                      color: Colors.red,
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    PieChartSectionData(
                      value: totalTrocados.toDouble(),
                      title: "Troca\n$totalTrocados",
                      color: Colors.purple,
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 15,
            runSpacing: 10,

            children: [

              legenda(Colors.green, "Coleção"),
              legenda(Colors.blue, "Wishlist"),
              legenda(Colors.orange, "Emprestado"),
              legenda(Colors.red, "Vendido"),
              legenda(Colors.purple, "Trocado"),

            ],
          ),

            const SizedBox(
              height: 25,
            ),

            Card(
              child: ListTile(
                title: const Text(
                  "Valor investido",
                ),

                subtitle: Text(
                  "R\$ ${totalInvestido.toStringAsFixed(2)}",
                ),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text(
                  "Total de jogos",
                ),

                subtitle: Text(
                  jogos.length.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget legenda(Color cor, String texto) {
    return Row(
      mainAxisSize: MainAxisSize.min,

      children: [

        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: cor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        const SizedBox(width: 5),

        Text(texto),
      ],
    );
  }

}