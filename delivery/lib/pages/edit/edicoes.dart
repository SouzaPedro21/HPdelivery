import 'package:flutter/material.dart';

class Edicoes extends StatelessWidget {
const Edicoes({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDITAR'),
        backgroundColor: const Color.fromARGB(255, 185, 187, 190),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 185, 187, 190),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            SizedBox(
              width: 400,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/editar_Cliente');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 168, 72, 12),
                ),
                child: const Text(
                  "EDITAR CLIENTE", 
                ),
              ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              width: 400,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/editarPedido');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 168, 72, 12),
                ),
                child: const Text(
                  "EDITAR PEDIDO", 
                  
                ),
              ),
            ),

          ]
        )
      )
    );
  }
}