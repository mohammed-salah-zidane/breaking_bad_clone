import 'package:breaking_bad_clone/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController searchTextController;
  final Function(String) onSearch;

  const SearchTextField(
      {Key? key, required this.onSearch, required this.searchTextController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchTextController,
      cursorColor: AppColors.appGray,
      decoration: const InputDecoration(
        hintText: 'Find a character....',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: const TextStyle(color: AppColors.appGray),
      onChanged: onSearch,
    );
  }
}
