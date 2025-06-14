import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/theme_provider.dart';
import '../screens/home_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/stats_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/about_screen.dart';
import '../screens/splash_screen.dart';

class PokedexApp extends StatefulWidget {
  const PokedexApp({super.key});

  @override
  State<PokedexApp> createState() => _PokedexAppState();
}

class _PokedexAppState extends State<PokedexApp> with TickerProviderStateMixin {
  Set<String> favorites = {};
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadFavorites();
    Provider.of<ThemeProvider>(context, listen: false).loadThemePreference();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites = prefs.getStringList('favorites')?.toSet() ?? {};
    });
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites.toList());
  }

  void _toggleFavorite(String name) {
    setState(() {
      if (favorites.contains(name)) {
        favorites.remove(name);
      } else {
        favorites.add(name);
      }
      _saveFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Pokédex',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.themeMode,
          home: SplashScreen(
            onInitializationComplete: () => Scaffold(
              appBar: AppBar(
                title: const Text('Pokédex'),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () => _tabController.animateTo(3),
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
                        ),
                      ),
                    ),
                  ),
                ],
                bottom: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(icon: Icon(Icons.home), text: 'Home'),
                    Tab(icon: Icon(Icons.favorite), text: 'Favoritos'),
                    Tab(icon: Icon(Icons.bar_chart), text: 'Stats'),
                    Tab(icon: Icon(Icons.settings), text: 'Configurações'),
                  ],
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  HomeScreen(
                    onToggleFavorite: _toggleFavorite,
                    favorites: favorites,
                  ),
                  FavoritesScreen(favorites: favorites),
                  const StatsScreen(),
                  const SettingsScreen(),
                ],
              ),
            ),
          ),
          routes: {
            '/detail': (ctx) {
              final pokemon = ModalRoute.of(ctx)!.settings.arguments as Map<String, dynamic>;
              return DetailScreen(
                pokemon: pokemon,
                isFavorite: favorites.contains(pokemon['name']),
                onToggleFavorite: _toggleFavorite,
              );
            },
            '/about': (context) => const AboutScreen(),
          },
        );
      },
    );
  }
}
