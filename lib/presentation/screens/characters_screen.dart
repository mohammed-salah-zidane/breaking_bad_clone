import 'package:breaking_bad_clone/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad_clone/core/constants/app_colors.dart';
import 'package:breaking_bad_clone/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late CharactersCubit _charactersCubit;

  @override
  void initState() {
    super.initState();
    _charactersCubit = BlocProvider.of<CharactersCubit>(context);
    _charactersCubit.getAllCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appYellow,
        title: const Text(
          'Characters',
          style: TextStyle(color: AppColors.appGray),
        ),
      ),
      body: buildBlocWidget(),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          return buildLoadedListWidgets();
        }
        return showLoadingIndicator();
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.appYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.appGray,
        child: Column(
          children: [
            buildCharacterList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharacterList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 4,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: _charactersCubit.characters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: _charactersCubit.characters[index],
        );
      },
    );
  }
}
