import 'package:cocktaildbhttpusing/res/colors.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        // @TODO не удается задать цвет границе
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.aHintColor,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(32.0),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 32.0),
          hintText: 'What to search?',
          hintStyle: const TextStyle(color: AppColors.aHintColor),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: const Icon(Icons.close, color: AppColors.aHintColor),
        ),
        maxLines: 1,
      ),
    );
  }
}
