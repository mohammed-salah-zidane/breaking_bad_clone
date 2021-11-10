import 'package:breaking_bad_clone/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad_clone/core/constants/app_colors.dart';
import 'package:breaking_bad_clone/data/models/character.dart';
import 'package:breaking_bad_clone/data/models/quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context)
        .getCharacterQuote(widget.character.name ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appGray,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CharacterInfo(
                        title: 'Job : ',
                        value: widget.character.jobsString ?? "",
                      ),
                      const AppDivider(
                        endIndent: 315,
                      ),
                      CharacterInfo(
                        title: 'Appeared in : ',
                        value: widget.character.categoryForTwoSeries ?? "",
                      ),
                      const AppDivider(
                        endIndent: 240,
                      ),
                      CharacterInfo(
                        title: 'Seasons : ',
                        value: widget.character.appearance ?? "",
                      ),
                      const AppDivider(
                        endIndent: 270,
                      ),
                      CharacterInfo(
                        title: 'Status : ',
                        value: widget.character.status ?? "",
                      ),
                      const AppDivider(
                        endIndent: 290,
                      ),
                      CharacterInfo(
                        title: 'Better Call Sauk Seasons : ',
                        value:
                            widget.character.betterCallSaulAppearanceString ??
                                "",
                      ),
                      const AppDivider(
                        endIndent: 150,
                      ),
                      CharacterInfo(
                        title: 'Actor/Actress : ',
                        value: widget.character.actorName ?? "",
                      ),
                      const AppDivider(
                        endIndent: 230,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      buildQuoteWidget(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.appGray,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          '${widget.character.nickname}',
          style: const TextStyle(
            color: AppColors.appWhite,
          ),
          textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: widget.character.charId ?? 0,
          child: Image.network(
            widget.character.img ?? "",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildQuoteWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharacterQuotesLoaded) {
          return showQuotesAnimator(state.quotes);
        }
        return showLoadingIndicator();
      },
    );
  }

  Widget showQuotesAnimator(List<Quote> quotes) {
    if (quotes.isNotEmpty) {
      return DefaultTextStyle(
        style: const TextStyle(
          fontSize: 20.0,
          color: AppColors.appWhite,
          shadows: [
            Shadow(
              blurRadius: 7,
              color: AppColors.appYellow,
              offset: Offset(
                0,
                0,
              ),
            ),
          ],
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            ...quotes.map<FlickerAnimatedText>(
              (charQuote) {
                return FlickerAnimatedText(
                  '"${charQuote.quote}"',
                );
              },
            ),
          ],
          isRepeatingAnimation: true,
        ),
      );
    }
    return Container();
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.appYellow,
      ),
    );
  }
}

class CharacterInfo extends StatelessWidget {
  final String title;
  final String value;

  const CharacterInfo({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: AppColors.appWhite,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.appWhite,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class AppDivider extends StatelessWidget {
  final double endIndent;

  const AppDivider({Key? key, required this.endIndent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: AppColors.appYellow,
      thickness: 2,
    );
  }
}
