import 'dart:io';
import 'dart:convert';

import 'package:dart_space_adventure/dart_space_adventure.dart';

void main(List<String> arguments) {
  final filePath = checkArgs(arguments);
  final system = loadPlanetarySystemFromJson(filePath);
  SpaceAdventure(planetarySystem: system).start();
}

String checkArgs(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: dart run bin/main.dart <path_to_json>');
    exit(1);
  }
  return arguments.first;
}

PlanetarySystem loadPlanetarySystemFromJson(String filePath) {
  final jsonString = loadJson(filePath);
  final jsonMap = parseJson(jsonString);
  return PlanetarySystem.fromJson(jsonMap);
}

String loadJson(String filePath) {
  final file = File(filePath);
  if (!file.existsSync()) {
    print('File not found: $filePath');
    exit(1);
  }

  final jsonString = file.readAsStringSync();
  return jsonString;
}

Map<String, dynamic> parseJson(String jsonString) {
  try {
    return jsonDecode(jsonString);
  } on Exception catch (e) {
    print('Invalid JSON: $e');
    exit(1);
  }
}
