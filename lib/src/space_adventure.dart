import 'dart:io';
import 'planetary_system.dart';

class SpaceAdventure {
  static SpaceAdventure? _instance;
  late PlanetarySystem planetarySystem;

  factory SpaceAdventure({required PlanetarySystem planetarySystem}) {
    _instance ??= SpaceAdventure._internal();
    _instance!.planetarySystem = planetarySystem;
    return _instance!;
  }

  SpaceAdventure._internal();

  void start() {
    printGreeting();
    printIntroduction(responseToPrompt("What is your name?"));
    print('Lets go on an adventure!');
    travel(
      promptForRandomOrSpecificDestination(
        'Shall I randomly choose a planet for you to visit? (Y or N)',
      ),
    );
  }

  void printGreeting() {
    print('Welcome to the ${planetarySystem.name}');
    print('There are 8 planets to explore');
  }

  void printIntroduction(String name) {
    print(
      'Nice to meet you, $name. My name is Eliza, I\'m an old friend of Alexa.',
    );
  }

  String responseToPrompt(String prompt) {
    print(prompt);
    return stdin.readLineSync() ?? '';
  }

  void travelToRandomPlanet(String planetName) {
    print(
      'Ok! Traveling to $planetName...\n'
      'Arrived at $planetName! ',
    );
  }

  void travelTo(String planetName) {
    print(
      'Traveling to $planetName...\n'
      'Arrived at $planetName!',
    );
  }

  void travel(bool randomDestination) {
    if (randomDestination) {
      travelToRandomPlanet("any");
    } else {
      travelTo(responseToPrompt('Name the planet you would like to visit'));
    }
  }

  bool promptForRandomOrSpecificDestination(String prompt) {
    String? answer;
    while (answer != 'Y' && answer != 'N') {
      answer = responseToPrompt(prompt);
      if (answer == 'Y') {
        return true;
      } else if (answer == 'N') {
        return false;
      } else {
        print('Sorry I didn\'t get that');
      }
    }
    return false;
  }
}
