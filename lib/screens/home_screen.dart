import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:recipes_flutter/providers/recipes_provider.dart';
import 'package:recipes_flutter/screens/recipe_detail.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipesProvider = Provider.of<RecipesProvider>(context, listen: false);
    recipesProvider.fetchRecipes();

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
        body: Consumer<RecipesProvider>(builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.recipes.isEmpty) {
            return const Center(child: Text('No recipes found'));
          } else {
            return ListView.builder(
                itemCount: provider.recipes.length,
                itemBuilder: (context, index) {
                  return _RecipesCard(context, provider.recipes[index]);
                });
          }
        }));
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              width: MediaQuery.of(context).size.width,
              height: 600,
              color: Colors.white,
              child: const RecipeForm(),
            ));
  }

  Widget _RecipesCard(BuildContext context, dynamic recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    RecipeDetail(recipeName: recipe.name)));
      },
      child: Padding(
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
                  child:
                      Image.network(recipe.imageLink, fit: BoxFit.cover)), // Change image_link to imageLink
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Is possible to use a column to organize the widgets vertically
                  Text(recipe.name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand')),
                  Container(height: 2, width: 125, color: Colors.amber[700]),
                  Text(
                    'By ${recipe.author}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                ])
          ])),
        ),
      ),
    );
  }
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _recipeName = TextEditingController();
    final TextEditingController _recipeAuthor = TextEditingController();
    final TextEditingController _recipeImage = TextEditingController();
    final TextEditingController _recipeDescription = TextEditingController();

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
                _buildTextField(
                    controller: _recipeName,
                    label: "Name of the recipe",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name of the recipe';
                      }
                    }),
                const SizedBox(
                  height: 16,
                ),
                _buildTextField(
                    controller: _recipeAuthor,
                    label: "Author",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name of the author';
                      }
                    }),
                const SizedBox(
                  height: 16,
                ),
                _buildTextField(
                    controller: _recipeImage,
                    label: 'Image Url',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                    }),
                const SizedBox(
                  height: 16,
                ),
                _buildTextField(
                    maxLines: 4,
                    controller: _recipeDescription,
                    label: 'Recipe',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                    }),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 32, vertical: 16)
                    ),
                    child: const Text(
                      'Save Recipe',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )));
  }
}

Widget _buildTextField(
    {required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontFamily: 'Quicksand', color: Colors.black),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black, width: 1)),
    ),
    validator: validator,
    maxLines: maxLines,
  );
}
