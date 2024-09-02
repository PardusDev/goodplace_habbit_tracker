import 'package:flutter/material.dart';

class StreakInfoCard extends StatelessWidget {
  final String currentStreak;
  final String maxStreak;
  const StreakInfoCard({super.key, required this.currentStreak, required this.maxStreak});

  @override
  Widget build(BuildContext context) {
      return Container(
        width: double.infinity,
        height: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage("assets/images/Dots.png"),
            fit: BoxFit.cover,
            alignment: Alignment(0, 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$currentStreak Day",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Your current streak",
                style: TextStyle(
                    color: Color.fromARGB(255, 80, 80, 80),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "$maxStreak Day",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Your longest streak",
                style: TextStyle(
                    color: Color.fromARGB(255, 80, 80, 80),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
  }
}
