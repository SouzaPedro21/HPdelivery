import 'package:flutter/material.dart';
import 'package:delivery/dao/pedidoDao.dart';
import 'package:delivery/dao/memory/pedidoDaoMemory.dart';
import 'package:delivery/models/pedido.dart';

// ignore: must_be_immutable
class CadastrarPedido extends StatelessWidget {
  CadastrarPedido({Key? key}) : super(key: key);

  final TextEditingController idClienteController = TextEditingController();
  final TextEditingController idProdutoController = TextEditingController();
  final TextEditingController obsPedidoController = TextEditingController();
  final TextEditingController precoPedidoController = TextEditingController();

  PedidoDao pedidoDao = pedidoDaoMemory();

  @override
  Widget build(BuildContext context) {
    void salvar() {
      final Pedido registro = Pedido(
        idPedido: '',
        idCliente: int.parse(idClienteController.text),
        idProduto: int.parse(idProdutoController.text),
        obsPedido: obsPedidoController.text,
        precoPedido: num.parse(precoPedidoController.text),
      );

      pedidoDao.inserir(registro);
      pedidoDao.postPedido();
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Pedido'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            campoDeTexto(idProdutoController, 'ID do Produto'),
            const SizedBox(height: 20),
            campoDeTexto(obsPedidoController, 'Observação do Pedido'),
            const SizedBox(height: 20),
            campoDeTexto(precoPedidoController, 'Preço do Pedido'),
            const SizedBox(height: 20),
            botaoSalvar(salvar),
            botaoRealizarPedido(context),
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

  Widget botaoRealizarPedido(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/cadastroPedido'); // Navega para a tela de cadastro de pedido
        },
        child: const Text(
          'Realizar Pedido',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
      ),
    );
  }
}
