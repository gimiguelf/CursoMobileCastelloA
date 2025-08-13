//converter json <-> dart
import 'dart:convert'; //não precisa instalar no pubspec /nativa do dart

void main(){
  String jsonString = '''{
                      "id": "abc123"
                      "nome":"Pedro",
                      "idade":25,
                      "ativo":true
                      "login":"UserPedro",
                      "password":"1234"
                    }''';
  //decode jsonstring
  Map<String,dynamic> usuario = json.decode(jsonString);
  print(usuario["nome"]); //Pedro
  print(usuario["login"]); //UserPedro

  // modificar  a Senha para 6 digitos / Salvar no JsonString

  usuario["password"] = "123456";

  //gravar no jason
  
  jsonString = json.encode(usuario);

  print(jsonString);
}