import 'package:breaking_bad_clone/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad_clone/core/constants/strings.dart';
import 'package:breaking_bad_clone/data/models/character.dart';
import 'package:breaking_bad_clone/data/repository/characters_repository.dart';
import 'package:breaking_bad_clone/data/web_services/characters_web_services.dart';
import 'package:breaking_bad_clone/presentation/screens/characters_details_screen.dart';
import 'package:breaking_bad_clone/presentation/screens/characters_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository _charactersRepository;
  late CharactersCubit _charactersCubit;

  AppRouter() {
    _charactersRepository = CharactersRepository(CharactersWebServices());
    _charactersCubit = CharactersCubit(_charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => _charactersCubit,
            child: const CharacterScreen(),
          ),
        );

      case AppConstants.charactersDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (BuildContext context) =>
                  CharactersCubit(_charactersRepository),
              child: CharacterDetailsScreen(character: character)),
        );
    }
  }
}
