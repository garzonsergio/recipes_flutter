import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_flutter/models/recipe_model.dart';
import 'package:recipes_flutter/providers/recipes_provider.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipesData;
  const RecipeDetail({super.key, required this.recipesData});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  bool isFavorite = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipesProvider>(context, listen: false)
        .favoriteRecipe
        .contains(widget.recipesData);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.recipesData.name,
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red[900],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await Provider.of<RecipesProvider>(context, listen: false)
                      .toggleFavoriteStatus(widget.recipesData);
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border))
          ]),
      body: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(children: [
            Image.network(widget.recipesData.imageLink),
            SizedBox(height: 8),
            Text(widget.recipesData.name),
            SizedBox(height: 8),
            Text(widget.recipesData.author),
            SizedBox(height: 8),
            Text("Recipe Steps"),
            for (var step in widget.recipesData.recipeSteps) Text("- $step")
          ])),
    );
  }
}
