import 'package:flutter/material.dart';

class Cadastros extends StatelessWidget {
const Cadastros({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastros'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            SizedBox(
              width: 240,
              height: 40,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cadastroCliente');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                ),
                child: const Text(
                  "CADASTRAR CLIENTE", 
                ),
              ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              width: 240,
              height: 40,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cadastroPedido');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                ),
                child: const Text(
                  "CADASTRAR PEDIDO", 
                  
                ),
              ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              width: 240,
              height: 40,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cadastroProduto');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                ),
                child: const Text(
                  "CADASTRAR PRODUTO", 
                  
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}