import 'dart:io';
import 'dart:math';

import 'planet.dart';
import 'planetary_system.dart';

class SpaceAdventure {
  static SpaceAdventure? _instance;
  late final PlanetarySystem planetarySystem;

  //credit to chatGPT for showing me how to make a singleton in dart
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
    if (planetarySystem.hasPlanets) {
      travel(
        promptForRandomOrSpecificDestination(
          'Shall I randomly choose a planet for you to visit? (Y or N)',
        ),
      );
    } else {
      print('Darn, no planets here.');
    }
  }

  void printGreeting() {
    print('Welcome to the ${planetarySystem.name}');
    print('There are ${planetarySystem.numberOfPlanets} planets to explore');
  }

  void printIntroduction(String name) {
    print(
      'Nice to meet you, $name. My name is Eliza, I\'m an old friend of Alexa.',
    );
  }

  String responseToPrompt(String prompt) {
    while (true) {
      print(prompt);

      final input = stdin.readLineSync();

      if (input == null) {
        print('Please enter your name.');
        continue;
      }
      final trimmed = input.trim();

      if (trimmed.isEmpty) {
        print('Input cannot be empty.');
        continue;
      }
      return trimmed;
    }
  }

  void travel(bool randomDestination) {
    Planet planet;
    if (randomDestination) {
      planet = planetarySystem.randomPlanet();
    } else {
      planet = planetarySystem.planetWithName(
        responseToPrompt('Name the planet you would like to visit'),
      );
    }
    travelTo(planet);
  }

  void travelTo(Planet planet) {
    print('Traveling to ${planet.name}');
    print('Arrived at ${planet.name}. ${planet.description}');
  }

  bool promptForRandomOrSpecificDestination(String prompt) {
    var yesAnswers = {'y', 'yes'};
    var noAnswers = {'n', 'no'};
    //I decided I didn't know Yong's prompt loop
    while (true) {
      final answer = responseToPrompt(prompt)?.trim().toLowerCase();

      if (answer == null || answer.isEmpty) {
        print("Please enter yes or no");
        continue;
      }
      if (yesAnswers.contains(answer)) {
        return true;
      }
      if (noAnswers.contains(answer)) {
        return false;
      }

      print("Sorry I didn\'t get that");
    }
  }
}
