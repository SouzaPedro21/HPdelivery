import 'dart:async';
import 'package:delivery/dao/clienteDao.dart';
import 'package:delivery/models/cliente.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ClienteDaoMemory implements ClienteDao {
  static final ClienteDaoMemory _instance = ClienteDaoMemory._();
  ClienteDaoMemory._();
  static ClienteDaoMemory get instance => _instance;
  factory ClienteDaoMemory() => _instance;

  late final DatabaseReference clientesReference = FirebaseDatabase.instance.ref().child('clientes');
  late StreamSubscription<DatabaseEvent> clientesSubscription;

  List<Cliente> dados = [
    Cliente(
      idCliente: 1,
      nomeCliente: '',
      cpfCliente: '111.111.111-11',
      telefone: '(27) 77777-7777',
      email: 'pedrin190@gmail.com',
      senha: '',
    )
  ];

  @override
  bool alterar(Cliente cliente) {
    int ind = dados.indexOf(cliente);
    if (ind >= 0) {
      dados[ind] = cliente;
      return true;
    }
    return false;
  }

  @override
  bool excluir(Cliente cliente) {
    int ind = dados.indexOf(cliente);
    if (ind >= 0) {
      dados.removeAt(ind);
      return true;
    }
    return false;
  }

  @override
  bool inserir(Cliente cliente) {
    dados.add(cliente);
    cliente.idCliente = dados.length;
    return true;
  }

  @override
  List<Cliente> listarTodos() {
    return dados;
  }

  @override
  Cliente? selecionarPorId(int id) {
    for (int i = 0; i < dados.length; i++) {
      if (dados[i].idCliente == id) return dados[i];
    }
    return null;
  }
  
  @override
  void getCliente() async {
    try {
      final clienteSnapshot = await clientesReference.get();
      Map cliente;
      dados = [];
      for (var i = 1; i < (clienteSnapshot.value as List<dynamic>).length; i++) {
        cliente = (clienteSnapshot.value as List<dynamic>)[i];
        dados.add(
          Cliente(
            idCliente: i,
            nomeCliente: cliente['nome'],
            cpfCliente: cliente['cpf'],
            telefone: cliente['telefone'],
            email: cliente['email'],
            senha: cliente['senha']
          )
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void postCliente() async {
    Map<String, dynamic> mapDados = {};
    for (var cliente in dados) {
      mapDados[cliente.idCliente.toString()] = {
        'nome': cliente.nomeCliente,
        'cpf': cliente.cpfCliente,
        'telefone': cliente.telefone,
        'email': cliente.email,
      };
    }
    await clientesReference.set(mapDados);
  }
}
