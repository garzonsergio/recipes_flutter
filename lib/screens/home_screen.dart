import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context)
            .size
            .width, //Media query to set the width of the container to the width of the screen
        height: 125,
        child: Card(
            child: Row(children: <Widget>[
          Container(
              height: 125,
              width: 100,
              child: ClipRRect(
                  //This widget is a Rectangle with rounded corners
                  borderRadius: BorderRadius.circular(10),
                  child: Container())),
          const SizedBox(
            width: 20,
          ),
          Column(children: <Widget>[
            // Is possible to use a column to organize the widgets vertically
            Text("AAA"),
            Text("BBB"),
            Container(height: 2, width: 125, color: Colors.amber[700])
          ])
        ])),
      ),
    );
  }
}
