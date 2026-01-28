import 'dart:math';
import 'planet.dart';

class PlanetarySystem {
  final String name;
  final List<Planet> planets;
  final Random rand = Random();

  PlanetarySystem({this.name = "Unnamed System", this.planets = const []});

  factory PlanetarySystem.fromJson(Map<String, dynamic> json) {
    final planetsList = json['planets'] as List;
    return PlanetarySystem(
      name: json['name'],
      planets: planetsList.map((p) => Planet.fromJson(p)).toList(),
    );
  }

  int get numberOfPlanets => planets.length;
  bool get hasPlanets => planets.isNotEmpty;

  Planet randomPlanet() {
    if (!hasPlanets) return Planet.nullPlanet();
    return planets[rand.nextInt(numberOfPlanets)];
  }

  Planet planetWithName(String name) {
    return planets.firstWhere(
      (planet) => planet.name == name,
      orElse: () => Planet.nullPlanet(),
    );
  }
}
