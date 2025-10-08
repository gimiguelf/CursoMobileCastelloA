import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confSenhaField = TextEditingController();
  final _authController = FirebaseAuth.instance;
  bool _senhaOculta = true;
  bool _confSenhaOculta = true;

  void _registrar() async {
    if (_senhaField.text != _confSenhaField.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("As senhas não coincidem")),
      );
      return;
    }

    try {
      await _authController.createUserWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao registrar: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color softBlue = const Color(0xFFDBEAFE);
    final Color accentBlue = const Color(0xFF60A5FA);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Faixa azul no topo
          Container(
            height: 80,
            color: softBlue,
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Cadastro",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Campo Email
                  TextField(
                    controller: _emailField,
                    decoration: InputDecoration(
                      hintText: "Email:",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: softBlue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: accentBlue, width: 1.5),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  // Campo Senha
                  TextField(
                    controller: _senhaField,
                    obscureText: _senhaOculta,
                    decoration: InputDecoration(
                      hintText: "Senha:",
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _senhaOculta
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () =>
                            setState(() => _senhaOculta = !_senhaOculta),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: softBlue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: accentBlue, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo Confirmar Senha
                  TextField(
                    controller: _confSenhaField,
                    obscureText: _confSenhaOculta,
                    decoration: InputDecoration(
                      hintText: "Confirme sua senha:",
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confSenhaOculta
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () => setState(
                            () => _confSenhaOculta = !_confSenhaOculta),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: softBlue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: accentBlue, width: 1.5),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Botão de Cadastrar
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _registrar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: softBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Faixa azul inferior
          Container(
            height: 40,
            color: softBlue,
          ),
        ],
      ),
    );
  }
}
