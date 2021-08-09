import 'package:test_app/ui/main.dart';

class Pokemon {
  final String? name;
  final int? id;
  final int? height;
  final int? weight;
  final Sprite? sprites;
  final List<Type>? types;

  Pokemon(
      {this.name, this.id, this.height, this.weight, this.sprites, this.types});

  factory Pokemon.fromJson(dynamic json) {
    return Pokemon(
      name: json['name'] as String?,
      id: json['id'] as int?,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      sprites: Sprite.fromJson(json['sprites']),
      types: List<Type>.from(json['types'].map((i) => Type.fromJson(i))),
    );
  }
}

class Sprite {
  final String? frontDefault;
  final Other? other;

  Sprite({this.frontDefault, this.other});

  factory Sprite.fromJson(Map<String, dynamic> json) {
    return Sprite(
        frontDefault: json['front_default'] as String?,
        other: Other.fromJson(json['other']));
  }
}

class OfficialArtwork {
  final String? frontDefault;

  OfficialArtwork({this.frontDefault});

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) {
    return OfficialArtwork(frontDefault: json['front_default'] as String?);
  }
}

class Type {
  final String? name;

  Type({this.name});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(name: (json['type'] as Map?)!["name"] as String?);
  }
}

class Other {
  final OfficialArtwork? officialArtwork;

  Other({this.officialArtwork});

  factory Other.fromJson(Map<String, dynamic> json) {
    return Other(
        officialArtwork: OfficialArtwork.fromJson(json['official-artwork']));
  }
}
