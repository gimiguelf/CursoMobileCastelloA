import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // Controllers
  final _emailField = TextEditingController();
  final _usuarioField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confirmarSenhaField = TextEditingController();

  final _authController = FirebaseAuth.instance;
  bool _senhaOculta = true;

  // Método de Registro
  void _registrar() async {
    if (_senhaField.text != _confirmarSenhaField.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("As senhas não coincidem")),
      );
      return;
    }

    try {
      await _authController.createUserWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );
      Navigator.pop(context); // volta para login após cadastro
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao registrar: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Cadastro", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 32),
                TextField(
                  controller: _emailField,
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _usuarioField,
                  decoration: InputDecoration(labelText: "Nome de Usuário"),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _senhaField,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        _senhaOculta = !_senhaOculta;
                      }),
                      icon: _senhaOculta
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                  obscureText: _senhaOculta,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _confirmarSenhaField,
                  decoration: InputDecoration(labelText: "Confirmar Senha"),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registrar,
                  child: Text("Cadastrar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
