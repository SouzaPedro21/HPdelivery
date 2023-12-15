import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Importar a tela de Signup
import 'package:delivery/pages/signup.dart'; // Substitua com o caminho correto do arquivo

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seu Aplicativo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
      routes: {
        '/signup': (context) => SignupScreen(), // Definição da rota para a tela de Signup
      },
    );
  }
}

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void login() async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "teste1@gmail.com",
          password: "123456",
        );
        if (userCredential.user != null) {
          Navigator.of(context).pushNamed('/menu');
        }
      } on FirebaseAuthException catch (e) {
        print(e.code);
        print("Erro");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Faça o Login'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            SizedBox(
              width: 400,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
              ),
            ),
            const SizedBox(height: 50,),
            SizedBox(
              width: 400,
              child: TextField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
              ),
            ),
            const SizedBox(height: 50,),
            SizedBox(
              width: 200,
              child: TextButton(
                onPressed: login,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                ),
                child: const Text("LOGIN"),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/signup');
              },
              child: const Text(
                'Não tem cadastro? Cadastre-se agora',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
