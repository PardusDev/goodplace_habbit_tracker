import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/habit_detail/habit_detail_view_model.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page_view_model.dart';
import 'package:goodplace_habbit_tracker/utilities/date_formatter_to_show.dart';
import 'package:goodplace_habbit_tracker/widgets/Calendar.dart';
import 'package:goodplace_habbit_tracker/widgets/Drawer.dart';
import 'package:provider/provider.dart';

import '../../constants/string_constants.dart';
import '../../models/UserHabit.dart';

class HabitDetailPage extends StatefulWidget {
  const HabitDetailPage({super.key});

  @override
  _HabitDetailPageState createState() => _HabitDetailPageState();
}

class _HabitDetailPageState extends State<HabitDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as UserHabit;
      Provider.of<HabitDetailViewModel>(context, listen: false).setCurrentHabit(args);
      Provider.of<HabitDetailViewModel>(context, listen: false).fetchDoneHabitsForSpecificMonth(args, DateTime.now());
    });
  }

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
              Container(
                width: size.width,
                height: size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(userHabit.imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<HabitDetailViewModel>(
                    builder: (context, viewModel, child) {
                      return Text(
                        userHabit.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      );
                    }
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '🔥',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 4),
                      Consumer<HabitDetailViewModel>(
                        builder: (context, viewModel, child) {
                          return Text(
                            userHabit.maxStreak.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                userHabit.subject,
                style: const TextStyle(
                  color: Color.fromARGB(255, 200, 200, 200),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Creation Time: ${dateFormatterToShow(userHabit.createdAt)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              Consumer<HabitDetailViewModel>(
                  builder: (context, viewModel, child) {
                    return CalendarWidget(
                      onDaySelected: (day) {
                        // Do something with the selected day
                        viewModel.selectedDay = day;
                      },
                      onMonthChanged: (focusedDay) {
                        viewModel.fetchDoneHabitsForSpecificMonth(userHabit, focusedDay);
                      },
                      eventLoader: (day) {
                        return viewModel.events[day] ?? [];
                      }
                    );
                  }),
              const SizedBox(height: 30),
              Consumer<HabitDetailViewModel>(
                  builder: (context, viewModel, child) {
                    return Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            viewModel.toggleHabit(context, userHabit, viewModel.checkHabitIsCompletedForSelectedDate(userHabit));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: viewModel.checkHabitIsCompletedForSelectedDate(userHabit)
                                ? Colors.grey
                                : Colors.purple,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            viewModel.checkHabitIsCompletedForSelectedDate(userHabit) ? StringConstants.homePageHabitListTileButtonCompleted.toUpperCase() : StringConstants.homePageHabitListTileButton.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}