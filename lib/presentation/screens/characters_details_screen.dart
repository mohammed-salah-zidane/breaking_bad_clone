import 'package:breaking_bad_clone/core/constants/app_colors.dart';
import 'package:breaking_bad_clone/data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

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
                        value: character.jobsString ?? "",
                      ),
                      const AppDivider(
                        endIndent: 315,
                      ),
                      CharacterInfo(
                        title: 'Appeared in : ',
                        value: character.categoryForTwoSeries ?? "",
                      ),
                      const AppDivider(
                        endIndent: 240,
                      ),
                      CharacterInfo(
                        title: 'Seasons : ',
                        value: character.appearance ?? "",
                      ),
                      const AppDivider(
                        endIndent: 270,
                      ),
                      CharacterInfo(
                        title: 'Status : ',
                        value: character.status ?? "",
                      ),
                      const AppDivider(
                        endIndent: 290,
                      ),
                      CharacterInfo(
                        title: 'Better Call Sauk Seasons : ',
                        value: character.betterCallSaulAppearanceString ?? "",
                      ),
                      const AppDivider(
                        endIndent: 150,
                      ),
                      CharacterInfo(
                        title: 'Actor/Actress : ',
                        value: character.actorName ?? "",
                      ),
                      const AppDivider(
                        endIndent: 230,
                      ),
                      const SizedBox(
                        height: 30,
                      )
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
          '${character.nickname}',
          style: const TextStyle(
            color: AppColors.appWhite,
          ),
          textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.charId ?? 0,
          child: Image.network(
            character.img ?? "",
            fit: BoxFit.cover,
          ),
        ),
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
