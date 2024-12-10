import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_flutter/models/recipe_model.dart';
import 'package:recipes_flutter/providers/recipes_provider.dart';
import 'package:recipes_flutter/screens/recipe_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<RecipesProvider>(
            builder: (context, recipeProvider, child) {
          final favoritesRecipes = recipeProvider.favoriteRecipe;

          return favoritesRecipes.isEmpty
              ? Center(child: Text(AppLocalizations.of(context)!.noRecipes))
              : ListView.builder(
                  itemCount: favoritesRecipes.length,
                  itemBuilder: (context, index) {
                    return favoriteRecipesCard(recipe: favoritesRecipes[index]);
                  },
                );
        }));
  }
}

class favoriteRecipesCard extends StatelessWidget {
  final Recipe recipe;
  const favoriteRecipesCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecipeDetail(recipesData: recipe)));
        },
        child: Card(
            child: Column(
          children: [
            // Image.network(recipe.imageLink),
            Text(recipe.name),
            Text(recipe.author)
          ],
        )));
  }
}
