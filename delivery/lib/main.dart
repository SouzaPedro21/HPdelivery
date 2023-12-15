import 'package:delivery/firebase_options.dart';
import 'package:delivery/pages/cadastro/cadastro_Pedido.dart';
import 'package:delivery/pages/edit/edicoes.dart';
import 'package:delivery/pages/edit/editar_Cliente.dart';
import 'package:delivery/pages/login.dart';
import 'package:delivery/pages/menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:delivery/pages/list/listagens_.dart';
import 'package:delivery/pages/list/listagem_de_Pedidos.dart';
import 'package:delivery/pages/list/listagem_de_Produtos.dart';
import 'package:delivery/pages/edit/editar_Pedido.dart';
import 'package:delivery/pages/signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HP Delivery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/signup':(context) => SignupScreen(),
        '/cadastro_Pedido':(context) => CadastrarPedido(),
        '/menu': (context) => const Menu(),
        '/listagens': (context) => const Listagens(),
        '/listagemProdutos': (context) => ListagemDeProdutos(),
        '/listagemPedidos': (context) => listagemDePedidos(),
        '/edicoes': (context) => const Edicoes(),
        '/editar_Cliente': (context) => EditarCliente(idCliente: '',),
        '/editarPedido': (context) => EditarPedido(),
      }
    );
  }
}
