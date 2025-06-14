import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final Set<String> favorites;

  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: favorites.isEmpty
          ? const Center(child: Text('Nenhum favorito adicionado ainda.'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final name = favorites.elementAt(index);
                return Card(child: ListTile(title: Text(name)));
              },
            ),
    );
  }
}
