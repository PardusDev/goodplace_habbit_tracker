import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/widgets/CustomShimmer.dart';

import '../models/UserHabit.dart';

class HabitCardWithImageBackground extends StatelessWidget {
  final UserHabit userHabit;
  final String imageUrl;
  final VoidCallback onTap;
  const HabitCardWithImageBackground({super.key, required this.onTap, required this.imageUrl, required this.userHabit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Stack(
        children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
                placeholder: (context, url) => const SizedBox.expand(
                    child: CustomShimmer()
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        '🔥',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        userHabit.maxStreak.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userHabit.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        userHabit.subject,
                        style: const TextStyle(
                          color: Color.fromARGB(224, 224, 224, 255),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),

        ],
      ),
    );
  }
}
