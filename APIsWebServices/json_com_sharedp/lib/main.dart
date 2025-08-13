import 'dart:convert'; //biblioteca interna do dart não precisa instalar no pubspec

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(const MyApp());
}

//classe que chama a Mudança de estado
class MyApp extends StatefulWidget{ // permite mudança de estado
  //construtor
  const MyApp({super.key});

  //método de mudança de estado
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

}

//classe que vai montar(build) a tela
class _MyAppState extends State<MyApp>{
  //atributos
  bool _temaEscuro = false; //vai controler a mudança de tema
  late TextEditingController _nomeController; // vai contorlar a inserção de texto dentro do TextFormField

  //métodos
  //precisa carregar as informações logo no começo da aplicação
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nomeController = TextEditingController(); //inicializa o controlador de texto
    _carregarPreferencias();
  }

  void _carregarPreferencias() async{
    //estabelece conexão com o SharedPreferences(cache)
    final prefs = await SharedPreferences.getInstance();
    //busca um texto em formato jason com as informações do usuário

    String? jsonConfig = prefs.getString('config');
    if(jsonConfig != null){
      print(jsonConfig);
      Map<String, dynamic> config = json.decode(jsonConfig);
      setState(() { //chama a mudança de Tela
        _temaEscuro = config['temaEscuro'] ?? false; //Operador de coalescencia
        _nomeController.text = config['nome'] ?? ''; //se não tiver nome, coloca vazio
        
      });
    } // fim if
  }// fim metodo

  void _salvarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> config = {
      'temaEscuro': _temaEscuro,
      'nome': _nomeController.text.trim()
    };
    String jsonConfig = json.encode(config);
    prefs.setString('config', jsonConfig);

    //snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Prefenrencias Salvas!'))
    );
  }

  //precisa do build(montar a tela)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //operador Ternário (if else encurtado)
      theme: _temaEscuro ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: Text("Preferências do Usuário"),),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SwitchListTile(
                title: Text("Tema Escuro"),
                value: _temaEscuro, 
                onChanged: (value){
                  setState(() {
                    _temaEscuro = value;
                  });
                }),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: "Nome do usuario"),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: _salvarPreferencias, 
                  child: Text("Salvar Preferências")),
                SizedBox(height: 20,),
                Divider(),
                Text("Configurações Atuais:", style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("Tema: ${_temaEscuro ? "Escuro" : "Claro"}"),
                Text("Usuário: ${_nomeController.text}")
            ],
          ),
        ),
      ),
    );
    
  }
}
