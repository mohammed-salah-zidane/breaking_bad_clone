import 'package:bloc/bloc.dart';
import 'package:breaking_bad_clone/data/models/character.dart';
import 'package:breaking_bad_clone/data/repository/characters_repository.dart';
import 'package:equatable/equatable.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository _charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this._charactersRepository)
      : super(
          CharactersInitial(),
        );

  Future<void> getAllCharacter() async {
    final characters = await _charactersRepository.getAllCharacters();
    this.characters = characters;
    emit(CharactersLoaded(characters));
  }
}