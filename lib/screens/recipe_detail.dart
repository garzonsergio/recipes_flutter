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

//SingleTickerProviderStateMixin is used to animate the favorite icon in a customized way
class _RecipeDetailState extends State<RecipeDetail>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scaleAnimation = Tween<double>(begin: 1, end: 1.5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipesProvider>(context, listen: false)
        .favoriteRecipe
        .contains(widget.recipesData);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                icon: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white)))
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
