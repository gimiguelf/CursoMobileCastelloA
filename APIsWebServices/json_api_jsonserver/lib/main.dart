
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: TarefaPage()));
}

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TarefasPageState();
  }
}

class _TarefasPageState extends State<TarefaPage> {
  List tarefas = [];
  final TextEditingController _tarefaController = TextEditingController();
  static const String baseUrl = "http://10.109.197.14:3008/tarefas";

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  // carregar tarefas
  void _carregarTarefas() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        print("Resposta da API: ${response.body}");

        setState(() {
          List<dynamic> dados = json.decode(response.body);
          tarefas = dados.map((item) => Map<String, dynamic>.from(item)).toList();
        });
      }
    } catch (e) {
      print("Erro ao buscar tarefas: $e");
    }
  }

  // adicionar tarefa
  void _adicionarTarefa(String titulo) async {
    if (titulo.trim().isEmpty) return; // evita adicionar vazio
    final novaTarefa = {"titulo": titulo, "concluida": false};
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(novaTarefa),
      );
      if (response.statusCode == 201) {
        _tarefaController.clear();
        _carregarTarefas();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tarefa adicionada com sucesso")),
        );
      }
    } catch (e) {
      print("Erro ao adicionar tarefa: $e");
    }
  }

  // remover tarefa
  void _removerTarefa(String id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/$id"));
      if (response.statusCode == 200 || response.statusCode == 204) {
        _carregarTarefas();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tarefa apagada com sucesso")),
        );
      } else {
        print("Erro ao deletar. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao deletar tarefa: $e");
    }
  }

  //Modificar Tarefas -> /put ou patch
    void _atualizarTarefa(bool concluida, String id) async{
    final modificada= {"concluida": !concluida};
    try {
      final response = await http.patch(
        Uri.parse("$baseUrl/$id"),
        headers: {"Content-Type":"application/json"},
        body: json.encode(modificada) // convert dart -> json
      );
      if(response.statusCode ==200){
        _carregarTarefas();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tarefa Atualizada com Sucesso"), duration: Duration(seconds: 2),)
        );
      }
    } catch (e) {
      print("Erro ao Atualizar: $e");
    }
  }

   //build da Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas Via API"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(labelText: "Nova Tarefa", border: OutlineInputBorder()),
              onSubmitted: _adicionarTarefa,
            ),
            SizedBox(height: 10,),
            Expanded(
              //operador Ternário
              child: tarefas.isEmpty 
              ? Center(child: Text("Nenhuma Tarefa Adicionada"))
              : ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context,index){
                  final tarefa = tarefas[index];
                  return ListTile(
                    //leading -> checkbox - Atualização da Tarefa (concluída ou pendente)
                    leading: Checkbox(
                      value: tarefa["concluida"], 
                      onChanged: (value)=>_atualizarTarefa(tarefa["concluida"], tarefa["id"])),
                    title: Text(tarefa["titulo"]),
                    subtitle: Text(tarefa["concluida"] ? "Concluída" : "Pendente"),
                    trailing: IconButton(
                      onPressed: ()=> _removerTarefa(tarefa["id"]), 
                      icon: Icon(Icons.delete)),
                  );
                }))
          ],
        ),
      ),
    );
  }

}


