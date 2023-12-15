import 'dart:async';
import 'package:delivery/dao/entregaDao.dart';
import 'package:delivery/models/entrega.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EntregaDaoMemory implements EntregaDao {
  static final EntregaDaoMemory _instance = EntregaDaoMemory._();
  EntregaDaoMemory._();
  static EntregaDaoMemory get instance => _instance;
  factory EntregaDaoMemory() => _instance;

  late final DatabaseReference EntregasReference = FirebaseDatabase.instance.ref().child('Entregas');
  late StreamSubscription<DatabaseEvent> EntregasSubscription;

  List<Entrega> dados = [
    Entrega(
      idEntrega: 1,
      idCliente: 1,
      idPedido: 1,
      rua: '',
      bairro:'',
      numero: 1,
      descricao: '',
      dataHora: DateTime(2023, 12, 31, 08, 00)
    )
  ];

  @override
  bool alterar(Entrega Entrega) {
    int ind = dados.indexOf(Entrega);
    if (ind >= 0) {
      dados[ind] = Entrega;
      return true;
    }
    return false;
  }

  @override
  bool excluir(Entrega Entrega) {
    int ind = dados.indexOf(Entrega);
    if (ind >= 0) {
      dados.removeAt(ind);
      return true;
    }
    return false;
  }

  @override
  bool inserir(Entrega Entrega) {
    dados.add(Entrega);
    Entrega.idEntrega = dados.length;
    return true;
  }

  @override
  List<Entrega> listarTodos() {
    return dados;
  }

  @override
  Entrega? selecionarPorId(int id) {
    for (int i = 0; i < dados.length; i++) {
      if (dados[i].idEntrega == id) return dados[i];
    }
    return null;
  }
  
  @override
  void getEntrega() async {
    try {
      final EntregaSnapshot = await EntregasReference.get();
      Map entrega;
      dados = [];
      for (var i = 1; i < (EntregaSnapshot.value as List<dynamic>).length; i++) {
        entrega = (EntregaSnapshot.value as List<dynamic>)[i];
        dados.add(
          Entrega(
            idEntrega: i,
            idCliente: entrega['idCliente'],
            idPedido: entrega['idPedido'],
            rua: entrega['idPedido'],
            bairro:entrega['idPedido'],
            numero: entrega['idPedido'],
            descricao: entrega['idPedido'],
            dataHora: DateTime.parse(entrega['dataHora'])
          )
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void postEntrega() async {
    Map<String, dynamic> mapDados = {};
    for (var Entrega in dados) {
      mapDados[Entrega.idEntrega.toString()] = {
        'idCliente': Entrega.idCliente,
        'idPedido': Entrega.idPedido,
        'dataHora': Entrega.dataHora.toString(),
      };
    }
    await EntregasReference.set(mapDados);
  }
}
