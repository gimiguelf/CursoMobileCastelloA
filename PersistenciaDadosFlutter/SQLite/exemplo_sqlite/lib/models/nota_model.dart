//criar a classe model para notas
class Nota {
  //atributos
  final int? id; //nulo
  final String titulo;
  final String conteudo;

  //contrutor
  Nota({this.id, required this.titulo, required this.conteudo});

  //metodos
  //metodo MAP => converte um objt da class nota para um map 
  Map<String,dynamic>tomap(){
    return {
      "id" : id,
      "titulo": titulo,
      "conteudo": conteudo,
    };
  }
}
