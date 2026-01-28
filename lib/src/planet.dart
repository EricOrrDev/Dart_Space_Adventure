class Planet {
  final String name;
  final String description;

  Planet({this.name = "Unnamed Planet", this.description = "No Description"});

  Planet.nullPlanet() : name = 'Null', description = 'Null';

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(name: json['name'], description: json['description']);
  }
}
