class Cliente {
  int idCliente;
  String nomeCliente;
  String cpfCliente;
  String telefone;
  String email;
  String senha;

  Cliente({
    required this.idCliente,
    required this.nomeCliente,
    required this.cpfCliente,
    required this.telefone,
    required this.email,
    required this.senha,
  });

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      idCliente: map['idCliente'] as int,
      nomeCliente: map['nomeCliente'] as String,
      cpfCliente: map['cpfCliente'] as String,
      telefone: map['telefone'] as String,
      email: map['email'] as String,
      senha: map['senha'] as String,
    );
  }
}
