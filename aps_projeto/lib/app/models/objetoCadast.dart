import 'dart:convert';

class ObjetoCadastrar {
  int? id;
  String nome;
  String classificacao;
  String nomePessoa;
  String dataDevolucao;
  String observacoes;

  ObjetoCadastrar({
    this.id,
    required this.nome,
    required this.classificacao,
    required this.nomePessoa,
    required this.dataDevolucao,
    required this.observacoes,
  });

  // Converte o objeto FormData para um mapa para ser inserido no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'classificacao': classificacao,
      'nomePessoa': nomePessoa,
      'dataDevolucao': dataDevolucao,
      'observacoes': observacoes,
    };
  }

  factory ObjetoCadastrar.fromMap(Map<String, dynamic> map) {
    return ObjetoCadastrar(
      nome: map['nome'] ?? '',
      classificacao: map['classificacao'] ?? '',
      nomePessoa: map['nomePessoa'] ?? '',
      dataDevolucao: map['dataDevolucao'] ?? '',
      observacoes: map['observacoes'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ObjetoCadastrar.fromJson(String source) =>
      ObjetoCadastrar.fromMap(json.decode(source));
}
