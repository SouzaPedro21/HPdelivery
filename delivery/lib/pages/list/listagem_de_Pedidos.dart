import 'package:delivery/dao/memory/pedidoDaoMemory.dart';
import 'package:delivery/models/pedido.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class listagemDePedidos extends StatefulWidget {
  listagemDePedidos({ Key? key }) : super(key: key);

  @override
  State<listagemDePedidos> createState() => _listagemDePedidosState();
}

class _listagemDePedidosState extends State<listagemDePedidos> {
  List<DataRow> rows = [];

  List<Pedido> pedidos = pedidoDaoMemory().listarTodos();

  excluir(BuildContext context, Pedido pedido) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exclusão'),
          content: Text('Deseja Excluir?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  pedidoDaoMemory().excluir(pedido);
                  pedidoDaoMemory().postPedido();
                  Navigator.of(context).pop();
                });
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  List<DataRow> criarLinhas() {
    rows = [];
    for(Pedido i in pedidos) {
      rows.add(DataRow(cells: [
        DataCell(Text(i.idPedido.toString())),
        DataCell(Text(i.idCliente.toString())),
        DataCell(Text(i.idProduto.toString())),
        DataCell(Text(i.obsPedido.toString())),

      ],onLongPress: () => excluir(context, i)));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        backgroundColor: const Color.fromARGB(255, 185, 187, 190),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          DataTable(
            columns: const [
              DataColumn(label: Text('Id')),
              DataColumn(label: Text('Id')),
              DataColumn(label: Text('Cliente')),
              DataColumn(label: Text('obsPedido')),

            ], 
            rows: criarLinhas())
        ],
      ),
    );
  }
}