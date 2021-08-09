class Pokedex {
  final int? count;
  final String? next;
  final String? previous;
  final List<PokedexEntry>? results;

  Pokedex({this.count, this.next, this.previous, this.results});

  factory Pokedex.fromJson(Map<String, dynamic> json) {
    return Pokedex(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: json['results'] as List<PokedexEntry>?,
    );
  }
}

class PokedexEntry {
  final String? name;
  final String? url;

  PokedexEntry({this.name, this.url});

  factory PokedexEntry.fromJson(Map<String, dynamic> json) {
    return PokedexEntry(
        name: json['name'] as String?, url: json['url'] as String?);
  }
}
