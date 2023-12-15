class Pedido {
	String idPedido;
	int idCliente;
  int idProduto;
  String? obsPedido;
  num precoPedido;

  Pedido({
    required this.idPedido,
    required this.idCliente,
    required this.idProduto,
    required this.obsPedido,
    required this.precoPedido
  });
}