import 'package:delivery/models/produto.dart';

abstract class ProdutoDao {
  List<Produto> listarTodos();
  Produto? selecionarPorId(int id);
  bool inserir(Produto produto);
  bool alterar(Produto produto);
  bool excluir(Produto produto);
  void getProduto();
  void postProduto();
}