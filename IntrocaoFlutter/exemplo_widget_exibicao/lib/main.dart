import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

//construir a Janela
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Widget de Exibição"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Olá, Flutter!!!", 
            style: TextStyle(
              fontSize: 20,
              color: const Color.fromARGB(255, 11, 32, 221))), //texto Simples
            Text("Flutter é Incrível!!!", 
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
                letterSpacing: 2
              ),), // Texto Personalizado
            Icon(Icons.star, size: 50, color: Colors.amber,),
            IconButton(
             onPressed: ()=> print("Icone Pressionado"),
             icon: Icon(Icons.notifications, size: 50,)),
             //imagens
             Image.network("https://static.wikia.nocookie.net/dcverse/images/0/05/Mulher-Maravilha_DCEU_1.png/revision/latest/scale-to-width-down/275?cb=20171120203716",
             height: 300,
             width: 300,
             fit: BoxFit.cover,),
             //imagem local
             Image.asset("assets/img/maravilha.png",
             height: 300,
             width: 300,
             fit: BoxFit.cover,)
          ],
        ),
      )
    );
  }
}