import 'package:bloc/bloc.dart';
import 'package:breaking_bad_clone/data/models/character.dart';
import 'package:breaking_bad_clone/data/models/quote.dart';
import 'package:breaking_bad_clone/data/repository/characters_repository.dart';
import 'package:equatable/equatable.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository _charactersRepository;
  List<Character> _characters = [];

  List<Character> get characters => _characters;
  bool isSearch = false;
  CharactersCubit(this._charactersRepository)
      : super(
          CharactersInitial(),
        );

  Future<void> getAllCharacter() async {
    emit(CharactersLoading());
    final characters = await _charactersRepository.getAllCharacters();
    _characters = characters;
    emit(CharactersLoaded(characters));
  }

  Future<void> getCharacterQuote(String name) async {
    final quotes = await _charactersRepository.getCharacterQuotes(name);
    print(quotes);
    emit(CharacterQuotesLoaded(quotes));
  }

  void search(String searchKey) {
    final filteredCharacters = characters
        .where((character) => character.name!.toLowerCase().contains(searchKey))
        .toList();
    emit(CharactersFiltered(filteredCharacters));
  }

  void startSearch() {
    isSearch = true;
    emit(CharactersFiltered(characters));
  }

  void stopSearch() {
    isSearch = false;
    emit(CharactersLoaded(characters));
  }
}
