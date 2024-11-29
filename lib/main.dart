import 'package:flutter/material.dart';
import 'package:recipes_flutter/screens/home_screen.dart';

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

class RecipeBook extends StatelessWidget{
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black54,
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.search), text: 'Search')
            ],
          ),
          title: const Text(
            "Recipe Book",
            style: TextStyle(color: Colors.black54),
          ),
        ),
        body: const TabBarView(
          children: [
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}
