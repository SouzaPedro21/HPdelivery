class Entrega {
  int idEntrega;
  int idPedido;
  int idCliente;
  String rua;
  String bairro;
  int numero;
  String descricao;
  DateTime dataHora;

  Entrega({
    required this.idEntrega,
    required this.idPedido, 
    required this.idCliente,
    required this.rua,
    required this.bairro,
    required this.numero,
    required this.descricao,
    required this.dataHora,
    });
}