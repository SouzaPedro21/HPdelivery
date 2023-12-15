import 'package:delivery/models/entrega.dart';

abstract class EntregaDao {
  List<Entrega> listarTodos();
  Entrega? selecionarPorId(int id);
  bool inserir(Entrega entrega);
  bool alterar(Entrega entrega);
  bool excluir(Entrega entrega);
  void getEntrega();
  void postEntrega();
}