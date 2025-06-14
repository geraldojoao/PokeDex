import 'package:flutter/material.dart';
import '../widgets/pokemon_card.dart';
import '../services/pokemon_service.dart';
import '../utils/type_colors.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  final void Function(String) onToggleFavorite;
  final Set<String> favorites;
  const HomeScreen({super.key, required this.onToggleFavorite, required this.favorites});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Tela Inicial (Home)')), // Placeholder temporário
    );
  }
}

