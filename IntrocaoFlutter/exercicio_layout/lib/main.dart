import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    //routes - rotas de navegação +1 tela
  ));
}

//janela para estudo de layout (colums,rows, stacks,containers)
class MyApp extends StatelessWidget{
  const MyApp({super.key});

//sobrescrever o método build
@override
  Widget build(BuildContext context) {
    return Scaffold( //suporte da janela (appbar, body, bottonNB, drawer)
      appBar: AppBar(title:Text("Exemplo de Layout")),
      body: Container(
        color: const Color.fromARGB(255, 177, 195, 204),
         child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.black,
                  height: 200,
                  width: 200,
                ),

                Container(
                  color: Colors.red,
                  height: 150,
                  width: 150,
                ),

                 Image.asset("assets\img\image.png",
             height: 300,
             width: 300,
             fit: BoxFit.cover,),

                Icon(Icons.person, size: 100)
              ], 
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.green,
                  height: 100,
                  width: 100,
                ),

                Container(
                  color: Colors.yellow,
                  height: 100,
                  width: 100,
                ),

                Container(
                  color: Colors.orange,
                  height: 100,
                  width: 100,)
              ],
            ),
            Text("Observações Importantes")
        ]),
      ),
    );
  }
}