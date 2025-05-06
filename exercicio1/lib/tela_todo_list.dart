import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaTodoList extends StatefulWidget {
  const TelaTodoList({Key? key}) : super(key: key);

  @override
  _TelaTodoListState createState() => _TelaTodoListState();
}

class _TelaTodoListState extends State<TelaTodoList> {
  final TextEditingController _tarefaController = TextEditingController();
  List<String> _tarefas = [];

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  // Carregar as tarefas do SharedPreferences
  Future<void> _carregarTarefas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tarefas = prefs.getStringList('tarefas') ?? [];
    });
  }

  // Salvar as tarefas no SharedPreferences
  Future<void> _salvarTarefas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tarefas', _tarefas);
  }

  // Adicionar uma nova tarefa
  void _adicionarTarefa() {
    setState(() {
      if (_tarefaController.text.isNotEmpty) {
        _tarefas.add(_tarefaController.text);
        _tarefaController.clear();
        _salvarTarefas(); // Salva a lista de tarefas após adicionar uma nova.
      }
    });
  }

  // Remover uma tarefa
  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
      _salvarTarefas(); // Atualiza o armazenamento após remoção.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: const InputDecoration(labelText: 'Nova Tarefa'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarTarefa,
              child: const Text('Adicionar Tarefa'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(_tarefas[index]),
                    onDismissed: (direction) {
                      _removerTarefa(index);
                    },
                    child: ListTile(
                      title: Text(_tarefas[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
