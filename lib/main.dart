import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First commit',
      home: RecipeBook(),
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[900],
            title: const Text(
              "Recipe Book",
              style: TextStyle(color: Colors.black54),
            )),
        body: Container(
          width: MediaQuery.of(context).size.width, //Media query to set the width of the container to the width of the screen
          height:125,
          child: Card(
              child: Row(children: <Widget>[
            Container(
                height: 125,
                width: 100,
                child: ClipRRect( //This widget is a Rectangle with rounded corners
                    borderRadius: BorderRadius.circular(10),
                    child: Container())),
            const SizedBox(
              width: 20,
            ),
            Column(children: <Widget>[// Is possible to use a column to organize the widgets vertically
              Text("AAA"),
              Text("BBB"),
              Container(height: 2, width: 125, color: Colors.amber[700])
            ])
          ])),
        ));
  }
}
