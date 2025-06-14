import 'package:flutter/material.dart';
import '../utils/stat_colors.dart';
import 'progress_bar.dart';

class StatsBars extends StatelessWidget {
  final Map<String, dynamic> pokemon;

  const StatsBars({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> stats = pokemon['stats'];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: stats.map((stat) {
          String statName = stat['stat']['name'];
          int baseStat = stat['base_stat'];
          double percentage = baseStat / 100.0; // Normalize to 0-1 range

          return Column(
            children: [
              Text('$statName: $baseStat'),
              AnimatedLinearProgressIndicator(
                percentage: percentage,
                color: statColors[statName] ?? Colors.grey,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
