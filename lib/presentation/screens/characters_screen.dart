import 'package:breaking_bad_clone/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad_clone/core/constants/app_colors.dart';
import 'package:breaking_bad_clone/data/models/character.dart';
import 'package:breaking_bad_clone/presentation/widgets/character_item.dart';
import 'package:breaking_bad_clone/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late CharactersCubit _charactersCubit;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _charactersCubit = BlocProvider.of<CharactersCubit>(context);
    _charactersCubit.getAllCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.appYellow,
            leading: state is CharactersFiltered
                ? const BackButton(
                    color: AppColors.appGray,
                  )
                : Container(),
            title: state is CharactersFiltered
                ? buildSearchTextField()
                : buildAppBarTitle(),
            actions: _buildAppBarActions(state),
          ),
          body: buildBlocWidget(state),
        );
      },
    );
  }

  Widget buildBlocWidget(state) {
    if (state is CharactersLoaded) {
      return buildListWidget(state.characters);
    } else if (state is CharactersFiltered) {
      return buildListWidget(state.characters);
    } else if (state is CharactersLoading) {
      return showLoadingIndicator();
    }
    return buildListWidget(_charactersCubit.characters);
  }

  Widget showLoadingIndicator() {
    return Center(
      child: Image.asset('assets/images/loader.gif'),
    );
  }

  Widget buildListWidget(List<Character> characters) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.appGray,
        child: Column(
          children: [
            buildCharacterList(characters),
          ],
        ),
      ),
    );
  }

  Widget buildCharacterList(List<Character> characters) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: characters[index],
        );
      },
    );
  }

  List<Widget> _buildAppBarActions(state) {
    if (state is CharactersFiltered) {
      return [
        IconButton(
          onPressed: () {
            _stopSearching();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: AppColors.appGray,
          ),
        ),
      ];
    }

    return [
      IconButton(
        onPressed: _startSearch,
        icon: const Icon(
          Icons.search,
          color: AppColors.appGray,
        ),
      ),
    ];
  }

  Widget buildSearchTextField() {
    return SearchTextField(
      onSearch: (searchKey) {
        _charactersCubit.search(searchKey);
      },
      searchTextController: _searchTextController,
    );
  }

  Widget buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: AppColors.appGray),
    );
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    _charactersCubit.startSearch();
  }

  void _stopSearching() {
    setState(() {
      _searchTextController.clear();
    });
    _charactersCubit.stopSearch();
  }
}
