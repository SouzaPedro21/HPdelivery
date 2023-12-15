import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/cliente.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class EditarCliente extends StatefulWidget {
  final String idCliente;

  EditarCliente({Key? key, required this.idCliente}) : super(key: key);

  @override
  _EditarClienteState createState() => _EditarClienteState();
}

class _EditarClienteState extends State<EditarCliente> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    carregarCliente();
  }

  Future<void> carregarCliente() async {
  try {
    var doc = await FirebaseFirestore.instance.collection('clientes').doc(widget.idCliente).get().timeout(Duration(seconds: 10));
    if (doc.exists) {
      var cliente = Cliente.fromMap(doc.data()! as Map<String, dynamic>);
      setState(() {
        idController.text = cliente.idCliente.toString();
        nomeController.text = cliente.nomeCliente;
        cpfController.text = cliente.cpfCliente;
        telefoneController.text = cliente.telefone;
        emailController.text = cliente.email;
        isLoading = false;
      });
    } else {
      print('Documento não encontrado');
      setState(() => isLoading = false);
    }
  } catch (e) {
    print('Erro ao carregar cliente: $e');
    setState(() => isLoading = false);
  }
}

void salvar() async {
  var atualizadoCliente = {
    'nomeCliente': nomeController.text,
    'cpfCliente': cpfController.text,
    'telefone': telefoneController.text,
    'email': emailController.text,
  };

  try {
    await FirebaseFirestore.instance.collection('clientes').doc(widget.idCliente).update(atualizadoCliente);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cliente atualizado com sucesso!')),
    );
    Navigator.of(context).pop();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao atualizar cliente: $e')),
    );
  }
}

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Cliente'),
        centerTitle: true,
      ),
      body: isLoading
        ? Center(child: CircularProgressIndicator())
        : Center(
            child: Column(
              children: [
            const SizedBox(height: 40,),
            SizedBox(
              width: 400,
              child: TextField(
                controller: nomeController,
                style: TextStyle(

                ),
                decoration: InputDecoration(
                  labelText: 'Nome'
                ),
              ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              width: 400,
              child: TextFormField(
              controller: cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
            ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              width: 400,
              child: TextField(
                controller: telefoneController,
                style: TextStyle(

                ),
                decoration: InputDecoration(
                  labelText: 'Telefone'
                ),
              ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              width: 400,
              child: TextField(
                controller: emailController,
                style: TextStyle(

                ),
                decoration: InputDecoration(
                  labelText: 'E-mail'
                ),
              ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              height: 50,
              width: 200,
              child: TextButton(
                onPressed: salvar, 
                child: Text('Salvar', style: TextStyle(color: Colors.white, fontSize: 20),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String cpf = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cpf.length > 11) {
      cpf = cpf.substring(0, 11);
    }
    String formatted = cpf;
    if (cpf.length > 6) {
      formatted = cpf.substring(0, 3) + '.' + cpf.substring(3, 6) + '.' + cpf.substring(6, 9) + '-' + cpf.substring(9);
    } else if (cpf.length > 3) {
      formatted = cpf.substring(0, 3) + '.' + cpf.substring(3, 6) + (cpf.length > 6 ? '.' : '') + cpf.substring(6);
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}