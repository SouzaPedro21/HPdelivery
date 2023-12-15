import 'dart:async';
import 'package:delivery/dao/pedidoDao.dart';
import 'package:delivery/models/pedido.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class pedidoDaoMemory implements PedidoDao {
  static final pedidoDaoMemory _instance = pedidoDaoMemory._();
  pedidoDaoMemory._();
  static pedidoDaoMemory get instance => _instance;
  factory pedidoDaoMemory() => _instance;

  late final DatabaseReference pedidosReference = FirebaseDatabase.instance.ref().child('pedidos');
  late StreamSubscription<DatabaseEvent> pedidosSubscription;

  List<Pedido> dados = [
    Pedido(
      idPedido: '',
      idCliente: 1,
      idProduto: 1,
      obsPedido: "...",
      precoPedido: 1,
    )
  ];

  @override
  bool alterar(Pedido pedido) {
    int ind = dados.indexOf(pedido);
    if (ind >= 0) {
      dados[ind] = pedido;
      return true;
    }
    return false;
  }

  @override
  bool excluir(Pedido pedido) {
    int ind = dados.indexOf(pedido);
    if (ind >= 0) {
      dados.removeAt(ind);
      return true;
    }
    return false;
  }

  @override
  bool inserir(Pedido pedido) {
    dados.add(pedido);
    pedido.idPedido = dados.length as String;
    return true;
  }

  @override
  List<Pedido> listarTodos() {
    return dados;
  }

  @override
  Pedido? selecionarPorId(int id) {
    for (int i = 0; i < dados.length; i++) {
      if (dados[i].idPedido == id) return dados[i];
    }
    return null;
  }
  
  @override
  void getPedido() async {
    try {
      final pedidoSnapshot = await pedidosReference.get();
      Map pedido;
      dados = [];
      for (var i = 1; i < (pedidoSnapshot.value as List<dynamic>).length; i++) {
        pedido = (pedidoSnapshot.value as List<dynamic>)[i];
        dados.add(
          Pedido(
            idPedido: pedido['idPedido'],         
            idCliente: pedido['idCliente'],
            idProduto: pedido['idProduto'],
            obsPedido: pedido['obsPedido'],
            precoPedido: pedido ['precoPedido'],
        
          )
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void postPedido() async {
    Map<String, dynamic> mapDados = {};
    for (var pedido in dados) {
      mapDados[pedido.idPedido.toString()] = {
        'idCliente': pedido.idCliente,
        'idProduto': pedido.idProduto,
        'obsPedido': pedido.obsPedido,
      };
    }
    await pedidosReference.set(mapDados);
  }
}
