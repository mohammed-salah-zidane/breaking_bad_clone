part of 'characters_cubit.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();
}

class CharactersInitial extends CharactersState {
  @override
  List<Object> get props => [];
}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;

  const CharactersLoaded(this.characters);

  @override
  List<Object> get props => [characters];
}
