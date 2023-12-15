import 'dart:async';
import 'package:delivery/dao/produtoDao.dart';
import 'package:delivery/models/produto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class produtoDaoMemory implements ProdutoDao {
  static final produtoDaoMemory _instance = produtoDaoMemory._();
  produtoDaoMemory._();
  static produtoDaoMemory get instance => _instance;
  factory produtoDaoMemory() => _instance;

  late final DatabaseReference produtosReference = FirebaseDatabase.instance.ref().child('produtos');
  late StreamSubscription<DatabaseEvent> produtosSubscription;

  List<Produto> dados = [
    Produto(
      idProduto: 1,
      nomeProduto: 'Pizza de Frango',
      quantEstoque: 1,
      precoProd: 1,
    )
  ];

  @override
  bool alterar(Produto produto) {
    int ind = dados.indexOf(produto);
    print(dados.indexOf(produto));
    if (ind >= 0) {
      dados[ind] = produto;
      return true;
    }
    return false;
  }

  @override
  bool excluir(Produto produto) {
    int ind = dados.indexOf(produto);
    if (ind >= 0) {
      dados.removeAt(ind);
      return true;
    }
    return false;
  }

  @override
  bool inserir(Produto produto) {
    dados.add(produto);
    produto.idProduto = dados.length;
    return true;
  }

  @override
  List<Produto> listarTodos() {
    return dados;
  }

  @override
  Produto? selecionarPorId(int id) {
    for (int i = 0; i < dados.length; i++) {
      if (dados[i].idProduto == id) return dados[i];
    }
    return null;
  }
  
  @override
  void getProduto() async {
    try {
      final produtoSnapshot = await produtosReference.get();
      Map produto;
      dados = [];
      for (var i = 1; i < (produtoSnapshot.value as List<dynamic>).length; i++) {
        produto = (produtoSnapshot.value as List<dynamic>)[i];
        dados.add(
          Produto(
            idProduto: i,
            nomeProduto: produto['nome'],
            quantEstoque: produto['estoque'],
            precoProd: produto['custo']
          )
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void postProduto() async {
    Map<String, dynamic> mapDados = {};
    for (var produto in dados) {
      mapDados[produto.idProduto.toString()] = {
        'nome': produto.nomeProduto,
        'estoque': produto.quantEstoque,
        'custo': produto.precoProd,
      };
    }
    await produtosReference.set(mapDados);
  }
}
