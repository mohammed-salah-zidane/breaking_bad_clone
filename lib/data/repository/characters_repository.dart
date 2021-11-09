
import 'package:breaking_bad_clone/data/models/character.dart';
import 'package:breaking_bad_clone/data/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final charactersResponse = await charactersWebServices.getAllCharacters();
    final characters = charactersResponse.map((character) => Character.fromJson(character)).toList();
    return characters;
  }
}