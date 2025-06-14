class Pokemon {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final String imageUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      imageUrl: json['sprites']['front_default'] ??
          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    );
  }
}
