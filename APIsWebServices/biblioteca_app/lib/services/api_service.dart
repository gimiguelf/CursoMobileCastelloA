//classe que vai auxiliar as conexoes com o DB
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  //criar metodos de classe e não métodos de OBJ 
  //permite uma maior segurança na solicitação de requisições http
  //static -> metodos e atriutos de classe 

  static const String _baseUrl = "http://10.109.197.12:3008";

  //metodos da classe

  //get - pegar a lista de recursos
  static Future<List<dynamic>> getlist(String path) async{
    final res = await http.get(Uri.parse("$_baseUrl/$path"));
    //verifcar a resposta
    if(res.statusCode == 200) return json.decode(res.body);
    //se deu erro
    throw Exception("Erro ao carregar lista de $path");
  }

  //get - para pegar um unico recurso
  static Future<Map<String,dynamic>> getOne(String path, String id) async{
    final res = await http.get(Uri.parse("$_baseUrl/$path/$id"));
    //verifcar a resposta
    if(res.statusCode == 200) return json.decode(res.body);
    throw Exception("Falha ao Carregar Recurso de $path");
  }

  //post - adiconar recurso no BD
  static Future<Map<String,dynamic>> post(String path, Map<String,dynamic> body) async{
    final res = await http.post(
      Uri.parse("$_baseUrl/$path"),
      headers: {"Content-Type": "aplication/json"},
      body: json.encode(body));
    if(res.statusCode == 201) return json.decode(res.body);
    throw Exception("Falha ao Adiconar Recurso em $path");
  }

  //put - alterqa recusro do BD 
  static Future<Map<String,dynamic>> put(String path, Map<String,dynamic> body,String id) async{
    final res = await http.put(
      Uri.parse("$_baseUrl/$path/$id"),
      headers: {"Content-Type": "aplication/json"},
      body: json.encode(body));
    if(res.statusCode == 200) return json.decode(res.body);
    throw Exception("Falha ao Alterar Recurso em $path");
  }

  //deleta - recurso do bd
  static Future<void> delete(String path,String id) async{
    final res = await http.delete(Uri.parse("$_baseUrl/$path/$id"));
    if(res.statusCode != 200) throw Exception("Falha ao Deletar Recurso em $path");
  }
}
