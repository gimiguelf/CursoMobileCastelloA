import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:biblioteca_app/views/livro/livro_form_view.dart';
import 'package:flutter/material.dart';

class LivroListView extends StatefulWidget {
  const LivroListView({super.key});

  @override
  State<LivroListView> createState() => _LivroListViewState();
}

class _LivroListViewState extends State<LivroListView> {
  final _controller = LivroController();
  List<LivroModel> _livros = [];
  bool _carregando = true;
  final _buscaField = TextEditingController();
  List<LivroModel> _livrosFiltrados = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  _carregarDados() async {
    setState(() {
      _carregando = true;
    });
    try {
      _livros = await _controller.fetchAll();
      _livrosFiltrados = _livros;
    } catch (e) {
      // Tratar erro
    }
    setState(() {
      _carregando = false;
    });
  }

  void _delete(LivroModel livro) async {
    if (livro.id == null) return;
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmar Exclusão"),
        content: Text("Deseja realmente excluir o livro '${livro.titulo}'?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("Cancelar")),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Confirmar")),
        ],
      ),
    );
    if (confirmar == true) {
      try {
        await _controller.delete(livro.id!);
        _carregarDados();
      } catch (e) {
        // Tratar erro
      }
    }
  }

  void _filtrar() {
    final busca = _buscaField.text.toLowerCase();
    setState(() {
      _livrosFiltrados = _livros.where((livro) {
        return livro.titulo.toLowerCase().contains(busca) ||
            livro.autor.toLowerCase().contains(busca);
      }).toList();
    });
  }

  void _abrirForm() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LivroFormView()),
    );
    _carregarDados(); // Atualiza lista após criação
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _carregando
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _buscaField,
                    decoration: InputDecoration(labelText: "Pesquisar Livro"),
                    onChanged: (value) => _filtrar(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _livrosFiltrados.length,
                      itemBuilder: (context, index) {
                        final livro = _livrosFiltrados[index];
                        return Card(
                          child: ListTile(
                            title: Text(livro.titulo),
                            subtitle: Text(livro.autor),
                            trailing: IconButton(
                              onPressed: () => _delete(livro),
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirForm,
        child: Icon(Icons.add),
      ),
    );
  }
}
