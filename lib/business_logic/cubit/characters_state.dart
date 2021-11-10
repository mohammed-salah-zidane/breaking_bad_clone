part of 'characters_cubit.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();
}

class CharactersInitial extends CharactersState {
  @override
  List<Object> get props => [];
}

class CharactersLoading extends CharactersState {
  @override
  List<Object> get props => [];
}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;

  const CharactersLoaded(this.characters);

  @override
  List<Object> get props => [characters];
}

class CharactersFiltered extends CharactersState {
  final List<Character> characters;

  const CharactersFiltered(this.characters);

  @override
  List<Object> get props => [characters];
}

class CharacterQuotesLoaded extends CharactersState {
  final List<Quote> quotes;

  const CharacterQuotesLoaded(this.quotes);

  @override
  List<Object> get props => [quotes];
}