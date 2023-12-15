import 'package:flutter/material.dart';
import 'package:delivery/dao/pedidoDao.dart';
import 'package:delivery/dao/memory/pedidoDaoMemory.dart';
import 'package:delivery/models/pedido.dart';
// Importe suas classes DAO e modelos aqui

// ignore: must_be_immutable
class EditarPedido extends StatelessWidget {
  EditarPedido({Key? key}) : super(key: key);

  final TextEditingController idPedidoController = TextEditingController();
  final TextEditingController idProdutoController = TextEditingController();
  final TextEditingController obsPedidoController = TextEditingController();
  final TextEditingController precoPedidoController = TextEditingController();

  // Substitua por sua implementação DAO
  PedidoDao pedidoDao = pedidoDaoMemory();

  @override
  Widget build(BuildContext context) {
    void salvar() {
      final Pedido pedido = pedidoDaoMemory().selecionarPorId(int.parse(idPedidoController.text))!;
      pedido.idProduto = int.parse(idProdutoController.text);
      pedido.obsPedido = obsPedidoController.text;
      pedido.precoPedido = num.parse(precoPedidoController.text);

      pedidoDao.alterar(pedido);
      pedidoDao.postPedido();
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Pedido'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            campoDeTexto(idPedidoController, 'ID do Pedido'),
            const SizedBox(height: 20),
            campoDeTexto(idProdutoController, 'ID do Produto'),
            const SizedBox(height: 20),
            campoDeTexto(obsPedidoController, 'Observação do Pedido'),
            const SizedBox(height: 20),
            campoDeTexto(precoPedidoController, 'Preço do Pedido'),
            const SizedBox(height: 20),
            botaoSalvar(salvar)
          ],
        ),
      ),
    );
  }

  Widget campoDeTexto(TextEditingController controller, String label) {
    return SizedBox(
      width: 400,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget botaoSalvar(VoidCallback onPressed) {
    return SizedBox(
      height: 50,
      width: 200,
      child: TextButton(
        onPressed: onPressed,
        child: const Text(
          'Salvar',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
      ),
    );
  }
}
