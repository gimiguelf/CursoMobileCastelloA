//classe de modelagem,do usario (atributos = bd)
class UsuarioModel {
  //atributos
  final String? id; //pode ser nulo inicialmente 
  final String nome;
  final String email;

  //construtor
  UsuarioModel({
    this.id, required this.nome, required this.email
  });
  //fromJson - converte map em obj
  factory UsuarioModel.fromJson(Map<String,dynamic> json) => 
  UsuarioModel(
    id: json["id"].toString(),
    nome: json["nome"].toString(),
    email: json["email"].toString()
  );

  //toJson - converte obj em map
  Map<String,dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "email": email
  };
}
