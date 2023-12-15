class Produto {
  int idProduto;
  String nomeProduto;
  num quantEstoque;
  num precoProd;

  Produto({
    required this.idProduto,
    required this.nomeProduto,
    required this.quantEstoque,
    required this.precoProd,
  });

  // Construtor que cria um objeto Produto a partir de um mapa
  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      idProduto: map['idProduto'] as int,
      nomeProduto: map['nomeProduto'] as String,
      quantEstoque: map['quantEstoque'] as num,
      precoProd: map['precoProd'] as num,
    );
  }
}
