import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/habit_detail/habit_detail_view_model.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page_view_model.dart';
import 'package:goodplace_habbit_tracker/utilities/date_formatter_to_show.dart';
import 'package:goodplace_habbit_tracker/widgets/Calendar.dart';
import 'package:goodplace_habbit_tracker/widgets/Drawer.dart';
import 'package:provider/provider.dart';

import '../../models/UserHabit.dart';

class HabitDetailPage extends StatelessWidget {

  const HabitDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _homeModel = Provider.of<HomePageViewModel>(context, listen: true);
    var size = MediaQuery.of(context).size;

    final Object? args = ModalRoute.of(context)!.settings.arguments;
    final UserHabit userHabit = args as UserHabit;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 77, 87, 200),
      appBar: AppBar(
        title: const Text(
          'Habit Detail',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 100,
      ),
      drawer: MyDrawer(mainModel: _homeModel, currentPage: "Habit Detail"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Habit Image and Title Row
              Container(
                width: size.width,
                height: size.height/3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(userHabit.imagePath), // Replace with actual asset
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const  SizedBox(height: 25,),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Su İç', // Example Habit Name
                    style:  TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      Text(
                        '🔥',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 4),
                      Text(
                        "4",
                        style:  TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Habit Description
              Text(
                userHabit.subject, // Example description
                style: TextStyle(
                  color: Color.fromARGB(255, 200, 200, 200),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              // Creation Time
              Text(
                'Creation Time: ${dateFormatterToShow(userHabit.createdAt)}', // Example creation time
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              // Calendar Widget
              CalendarWidget(
                onDaySelected: (day) {
                  // Do something with the selected day
                },
              ),
              const SizedBox(height: 30),
              Consumer<HabitDetailViewModel>(
                builder: (context, viewModel, child) {
                  return Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          /*setState(() {
                            isHabitDone = !isHabitDone;
                          });
                          */
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: viewModel.checkHabitIsCompletedForSelectedDate(userHabit) ? Colors.grey : Colors.purple,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          viewModel.checkHabitIsCompletedForSelectedDate(userHabit) ? 'ALREADY DONE' : 'DO IT',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

