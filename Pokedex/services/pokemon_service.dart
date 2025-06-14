import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

  /// Busca a lista básica de Pokémon (nome e URL)
  static Future<List<Map<String, dynamic>>> fetchPokemonList({int limit = 100}) async {
    final response = await http.get(Uri.parse('$_baseUrl/pokemon?limit=$limit'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception('Falha ao carregar a lista de Pokémon');
    }
  }

  /// Busca os detalhes completos de um Pokémon usando a URL
  static Future<Pokemon?> fetchPokemonDetails(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Pokemon.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Erro ao buscar detalhes do Pokémon: $e');
      return null;
    }
  }

  /// Busca os tipos disponíveis
  static Future<List<String>> fetchTypes() async {
    final response = await http.get(Uri.parse('$_baseUrl/type'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<String>.from(data['results'].map((e) => e['name']));
    } else {
      throw Exception('Falha ao carregar os tipos');
    }
  }
}
