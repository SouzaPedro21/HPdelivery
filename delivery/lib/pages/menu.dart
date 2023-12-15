import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
const Menu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('OPÇÕES'),
        backgroundColor: const Color.fromARGB(255, 185, 187, 190),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                  Navigator.of(context).pushNamed('/cadastro_Pedido');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 168, 72, 12),
                ),
                child: const Text(
                  "REALIZAR PEDIDO", 
                  
                ),
              ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              width: 400,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/listagens');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 168, 72, 12),
                ),
                child: const Text(
                  "LISTAR", 
                  
                ),
              ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              width: 400,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/edicoes');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 168, 72, 12),
                ),
                child: const Text(
                  "EDITAR", 
                ),
              ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              width: 400,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 168, 72, 12),
                ),
                child: const Text(
                  "SAIR", 
                  
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}