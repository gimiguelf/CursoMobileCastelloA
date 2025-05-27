class Pet {
  //atributos -> id, nome, raça, nomeDono, telefoneDono
  final int? id; //pode ser nula
  final String nome;
  final String raca;
  final String nomeDono;
  final String telefone;

  //construtor
  Pet({
    this.id,
    required this.nome,
    required this.raca,
    required this.nomeDono,
    required this.telefone,
  });

  //método para converter o objeto em um mapa
  //to map : obj -> entidade bd
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "raca": raca,
      "nome_dono": nomeDono,
      "telefone": telefone,
    };
  }

  //método para criar um objeto Pet a partir de um mapa
  //frommap bd -> obj
  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map["id"] as int,
      nome: map["nome"] as String,
      raca: map["raca"] as String,
      nomeDono: map["nome_dono"] as String,
      telefone: map["telefone"] as String,
    );
  }
  @override
  String toString() {
    //TODO:implement toString
    return 'Pet{id: $id, nome: $nome, raca: $raca, dono: $nomeDono, telefone: $telefone}';
  }
}
