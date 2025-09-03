// classe Controller para livros
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class LivroController {

  //métodos
  //Get Usuários
  Future<List<LivroModel>> fetchAll() async{
    final list = await ApiService.getlist("livros");
    //retornar a lista de usuários
    return list.map<LivroModel>((e)=>LivroModel.fromJson(e)).toList();
  }
  //Get Usuário
  Future<LivroModel> fetchOne(String id) async{
    final user = await ApiService.getOne("livros", id);
    return LivroModel.fromJson(user);
  }

  //Post Usuário
  Future<LivroModel> create(LivroModel u) async{
    final created = await ApiService.post("livros", u.toJson());
    return LivroModel.fromJson(created);
  }

  //Put Usuário
  Future<LivroModel> update(LivroModel u) async{
    final updated = await ApiService.put("livros", u.toJson(), u.id!);
    return LivroModel.fromJson(updated);
  }

  //Delete Usuário
  Future<void> delete(String id) async{
    await ApiService.delete("livros", id); //não tem retorno
  }
}