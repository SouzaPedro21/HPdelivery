import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/produto.dart';
import 'package:flutter/material.dart';

class ListagemDeProdutos extends StatefulWidget {
  ListagemDeProdutos({Key? key}) : super(key: key);

  @override
  State<ListagemDeProdutos> createState() => _ListagemDeProdutosState();
}

class _ListagemDeProdutosState extends State<ListagemDeProdutos> {
  List<DataRow> rows = [];
  List<Produto> produtos = [];

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
    var colecao = FirebaseFirestore.instance.collection('produtos');
    var querySnapshot = await colecao.get();
    for (var doc in querySnapshot.docs) {
      var produto = Produto.fromMap(doc.data());
      setState(() {
        produtos.add(produto);
      });
    }
  }

  List<DataRow> criarLinhas() {
    rows = produtos.map((produto) {
      return DataRow(
        cells: [
          DataCell(Text(produto.idProduto.toString())),
          DataCell(Text(produto.nomeProduto)),
          DataCell(Text(produto.quantEstoque.toString())),
          DataCell(Text(produto.precoProd.toString())),
        ],
        onLongPress: () => excluir(context, produto),
      );
    }).toList();
    return rows;
  }

  excluir(BuildContext context, Produto produto) {
    // Lógica de exclusão aqui
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          DataTable(
            columns: const [
              DataColumn(label: Text('Id')),
              DataColumn(label: Text('Nome')),
              DataColumn(label: Text('Estoque')),
              DataColumn(label: Text('Preço')),
            ],
            rows: criarLinhas(),
          ),
        ],
      ),
    );
  }
}
