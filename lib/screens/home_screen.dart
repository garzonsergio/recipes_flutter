import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[900],
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            _showBottom(context);
          },
        ),
        body: Column(
          children: <Widget>[
            _RecipesCard(context),
            _RecipesCard(context),
            _RecipesCard(context),
          ],
        ));
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              color: Colors.white,
              child: const RecipeForm(),
            ));
  }

  Widget _RecipesCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context)
            .size
            .width, //Media query to set the width of the container to the width of the screen
        height: 125,
        child: Card(
            child: Row(children: <Widget>[
          SizedBox(
            height: 125,
            width: 100,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                    'https://cloudfront-us-east-1.images.arcpublishing.com/elespectador/JLYGWDUSXFDI7ITQECOXNAG674.jpg',
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Is possible to use a column to organize the widgets vertically
                const Text("Recipe name",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand')),
                Container(height: 2, width: 125, color: Colors.amber[700]),
                const Text(
                  "Author",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
              ])
        ])),
      ),
    );
  }
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add a new recipe',
                style: TextStyle(color: Colors.black, fontSize: 24)),
            const SizedBox(
              height: 16,
            ),
            _buildTextField(label: "Name of the recipe"),
            const SizedBox(
              height: 16,
            ),
            _buildTextField(label: "Author"),
            const SizedBox(
              height: 16,
            ),
            _buildTextField(label: 'Image Url'),
            const SizedBox(
              height: 16,
            ),
            _buildTextField(label: 'Recipe'),
            const SizedBox(
              height: 16,
            ),
          ],
        )));
  }
}

Widget _buildTextField({required String label}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontFamily: 'Quicksand', color: Colors.black),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black, width: 1)),
    ),
  );
}
