class GameModel {
  int? id;
  String nome;
  String plataforma;
  String categoria;
  String status;
  String raridade;
  double valorPago;
  double valorEstimado;
  String localizacao;
  String observacoes;
  String imagem;

  GameModel({
    this.id,
    required this.nome,
    required this.plataforma,
    required this.categoria,
    required this.status,
    required this.raridade,
    required this.valorPago,
    required this.valorEstimado,
    required this.localizacao,
    required this.observacoes,
    required this.imagem,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'plataforma': plataforma,
      'categoria': categoria,
      'status': status,
      'raridade': raridade,
      'valorPago': valorPago,
      'valorEstimado': valorEstimado,
      'localizacao': localizacao,
      'observacoes': observacoes,
      'imagem': imagem,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      id: map['id'],
      nome: map['nome'],
      plataforma: map['plataforma'],
      categoria: map['categoria'],
      status: map['status'],
      raridade: map['raridade'],
      valorPago: map['valorPago'],
      valorEstimado: map['valorEstimado'],
      localizacao: map['localizacao'],
      observacoes: map['observacoes'],
      imagem: map['imagem'],
    );
  }
}