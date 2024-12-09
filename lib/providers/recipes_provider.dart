import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:recipes_flutter/models/recipe_model.dart';

class RecipesProvider extends ChangeNotifier {
  bool isLoading = false;

  List<Recipe> recipes = []; //State that saves the recipes
  List<Recipe> favoriteRecipe = [];

  Future<void> fetchRecipes() async {
    //Android 10.0.2.2
    //IOS 127.0.0.1
    //Web localhost
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://10.0.2.2:12347/recipes');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        recipes = List<Recipe>.from(
            data['recipes'].map((recipe) => Recipe.fromJSON(recipe)));
        print('succesful request RR');
      } else {
        print('Error: ${response.statusCode}');
        recipes = [];
      }
    } catch (e) {
      print('Error in request');
      recipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Recipe recipe) async {
    final isFavorite = favoriteRecipe.contains(recipe);
    try {
      final url = Uri.parse('http://10.0.2.2:12347/favorites');
      final response = isFavorite
          ? await http.delete(url, body: json.encode({"id": recipe.id}))
          : await http.post(url, body: json.encode(recipe.toJSON()));

      if (response.statusCode == 200) {
        if (isFavorite) {
          favoriteRecipe.remove(recipe);
        } else {
          favoriteRecipe.add(recipe);
        }

        notifyListeners();
      } else {
        throw Exception('Failed to toggle favorite status');
      }
    } catch (e) {
      print(e);
    }
  }
}
