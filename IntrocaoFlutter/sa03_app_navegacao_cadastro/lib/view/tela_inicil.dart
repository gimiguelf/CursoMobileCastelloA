//classes

import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // primeira camada
      appBar: AppBar(title: Text("Bem-vindo!!!"), centerTitle: true),
      body: Center(
        // segunda camada
        child: Column(
          // terceira camada
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Aplicativo de Cadastro de Usuário",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/cadastro"),
              child: Text("Cadastro de Usuário"),
            ),
          ],
        ),
      ),
    );
  }
}
