import 'package:delivery/models/pedido.dart';

abstract class PedidoDao {
  List<Pedido> listarTodos();
  Pedido? selecionarPorId(int id);
  bool inserir(Pedido pedido);
  bool alterar(Pedido pedido);
  bool excluir(Pedido pedido);
  void getPedido();
  void postPedido();
}