import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar com ícones
      appBar: AppBar(
        title: Text("Perfil de Helena"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack para a imagem de perfil
            Stack(
              alignment: Alignment.center,
              children: [
                // Fundo circular com borda sombreada
                Container(
                  width: 130.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                // Imagem de perfil com borda estilizada
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage('https://www.example.com/imagem_de_perfil.jpg'), // Substitua pela URL da sua imagem
                ),
              ],
            ),
            SizedBox(height: 16.0),
            // Nome de Helena
            Text(
              'Helena Souza',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            // Descrição com uma frase mais feminina
            Text(
              'Sigo minha intuição e vivo com leveza, acreditando que cada momento tem seu encanto.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),

            // Outra informação pessoal (exemplo: idade, cidade)
            Text(
              'Idade: 28 anos',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Cidade: São Paulo',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 32.0),

            // Linha com 3 Containers coloridos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.pinkAccent,
                  child: Center(child: Text("Amor", style: TextStyle(color: Colors.white))),
                ),
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.purpleAccent,
                  child: Center(child: Text("Gratidão", style: TextStyle(color: Colors.white))),
                ),
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.orangeAccent,
                  child: Center(child: Text("Fé", style: TextStyle(color: Colors.white))),
                ),
              ],
            ),
            SizedBox(height: 32.0),

            // Lista de texto (informações adicionais)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hobby: Leitura", style: TextStyle(fontSize: 16)),
                Text("Profissão: Advogada", style: TextStyle(fontSize: 16)),
                Text("Objetivo: Estar em constante aprendizado", style: TextStyle(fontSize: 16)),
                Text("Lema: Siga seus sonhos", style: TextStyle(fontSize: 16)),
                Text("Música favorita: Jazz", style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 32.0),

            // Linha com ícones de redes sociais
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.facebook),
                  onPressed: () {},
                  iconSize: 30.0,
                  color: Colors.blueAccent,
                ),
                IconButton(
                  icon: Icon(Icons.alternate_email),
                  onPressed: () {},
                  iconSize: 30.0,
                  color: Colors.blue,
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {},
                  iconSize: 30.0,
                  color: Colors.pinkAccent,
                ),
              ],
            ),
          ],
        ),
      ),
      // BottomNavigationBar com ícones
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
