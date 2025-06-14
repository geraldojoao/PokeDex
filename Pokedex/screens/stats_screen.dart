import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  // A lógica da tela de estatísticas será separada posteriormente

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Estatísticas dos Pokémons')), // Placeholder
    );
  }
}
