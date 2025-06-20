import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RecipeCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const RecipeCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  });

  void _handleFavorite(BuildContext context) async {
    final AuthService _authService = AuthService();

    try {
      await _authService.saveFavorite(title);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Added "$title" to favorites!')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to save favorite.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.asset(
                    imagePath,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.star_border,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () => _handleFavorite(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
