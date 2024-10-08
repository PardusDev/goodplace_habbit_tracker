import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/widgets/HabitListTileButton.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';
import '../constants/string_constants.dart';
import 'HabitListTileCompletedButton.dart';

class HabitListTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  final VoidCallback onButtonPressed;
  final bool isCompleted;
  const HabitListTile({super.key, required this.title, required this.imageUrl, required this.onButtonPressed, required this.isCompleted, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
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
                    begin: Alignment.centerRight,
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
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.4),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                      title,
                      style: context.general.textTheme.titleLarge?.copyWith(
                        color: ColorConstants.homePageHabitListTileTitleColor,
                        fontWeight: FontWeight.w400,
                        shadows: [
                          const Shadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 25,
                          ),
                        ],
                        overflow: TextOverflow.ellipsis,
                      ),
                  ),
                ),
                isCompleted
                ? HabitListTileCompletedButton(onPressed: onButtonPressed, buttonText: StringConstants.homePageHabitListTileButtonCompleted)
                : HabitListTileButton(onPressed: onButtonPressed, buttonText: StringConstants.homePageHabitListTileButton)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
