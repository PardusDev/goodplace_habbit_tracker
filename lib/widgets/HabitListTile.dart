import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/widgets/HabitListTileButton.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';
import '../constants/string_constants.dart';
import 'HabitListTileCompletedButton.dart';

class HabitListTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onPressed;
  final bool isCompleted;
  const HabitListTile({super.key, required this.title, required this.imageUrl, required this.onPressed, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.white.withOpacity(1),
                    Colors.white.withOpacity(0.4),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  title,
                  style: context.general.textTheme.titleLarge?.copyWith(
                    color: ColorConstants.homePageHabitListTileTitleColor,
                    fontWeight: FontWeight.w400,
                    shadows: [
                      const Shadow(
                        color: Colors.black87,
                        offset: Offset(1, 1),
                        blurRadius: 30,
                      ),
                    ],
                  ),
              ),
              isCompleted
              ? HabitListTileCompletedButton(onPressed: onPressed, buttonText: StringConstants.homePageHabitListTileButtonCompleted)
              : HabitListTileButton(onPressed: onPressed, buttonText: StringConstants.homePageHabitListTileButton)
            ],
          ),
        ),
      ],
    );
  }
}
