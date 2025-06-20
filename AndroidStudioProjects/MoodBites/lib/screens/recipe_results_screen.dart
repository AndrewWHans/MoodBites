import 'package:flutter/material.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class RecipeResultsScreen extends StatelessWidget {
  final String selectedMood;

  const RecipeResultsScreen({super.key, required this.selectedMood});

  List<Map<String, dynamic>> _getRecipesByMood() {
    switch (selectedMood) {
      case 'Happy':
        return [
          {
            'title': 'Chocolate Sundae 🍨',
            'image': 'assets/icecream.jpg',
            'ingredients': ['Ice cream', 'Chocolate syrup', 'Cherries'],
          },
          {
            'title': 'Spicy Chicken Curry 🍛',
            'image': 'assets/chicken.jpg',
            'ingredients': ['Chicken', 'Spices', 'Coconut milk'],
          },
        ];
      case 'Sad':
        return [
          {
            'title': 'Creamy Soup 🍲',
            'image': 'assets/soup.jpg',
            'ingredients': ['Broth', 'Cream', 'Vegetables'],
          },
          {
            'title': 'Toasted Baguette 🥖',
            'image': 'assets/bread.jpg',
            'ingredients': ['Baguette', 'Butter', 'Garlic'],
          },
        ];
      case 'Cool':
        return [
          {
            'title': 'Classic Spaghetti 🍝',
            'image': 'assets/spaghetti.jpg',
            'ingredients': ['Spaghetti', 'Tomato sauce', 'Cheese'],
          },
          {
            'title': 'Loaded Burger 🍔',
            'image': 'assets/burger.jpg',
            'ingredients': ['Beef patty', 'Cheese', 'Bun'],
          },
        ];
      case 'Angry':
        return [
          {
            'title': 'Spicy Chicken Curry 🍛',
            'image': 'assets/chicken.jpg',
            'ingredients': ['Chicken', 'Spices', 'Coconut milk'],
          },
          {
            'title': 'Loaded Burger 🍔',
            'image': 'assets/burger.jpg',
            'ingredients': ['Beef patty', 'Cheese', 'Bun'],
          },
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipes = _getRecipesByMood();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Here are some food items!'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return RecipeCard(
                    imagePath: recipe['image'],
                    title: recipe['title'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => RecipeDetailScreen(
                                recipeTitle: recipe['title'],
                                ingredients: recipe['ingredients'],
                              ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
