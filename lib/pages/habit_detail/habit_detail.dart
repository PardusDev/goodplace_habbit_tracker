import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/image_constants.dart';
import 'package:goodplace_habbit_tracker/pages/habit_detail/habit_detail_view_model.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page_view_model.dart';
import 'package:goodplace_habbit_tracker/utilities/date_formatter_to_show.dart';
import 'package:goodplace_habbit_tracker/widgets/Calendar.dart';
import 'package:goodplace_habbit_tracker/widgets/Drawer.dart';
import 'package:goodplace_habbit_tracker/widgets/StadiumSideBlueIconButton.dart';
import 'package:kartal/kartal.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final _homeModel = Provider.of<HomePageViewModel>(context, listen: true);
    var size = MediaQuery.of(context).size;

    final Object? args = ModalRoute.of(context)!.settings.arguments;
    final UserHabit userHabit = args as UserHabit;

    return ChangeNotifierProvider<HabitDetailViewModel>(
      create: (context) => HabitDetailViewModel(currentHabit: userHabit),
      child: Scaffold(
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
            actions: [
              Consumer<HabitDetailViewModel>(
                builder: (context, viewModel, child) {
                  return IconButton(onPressed: (){
                    viewModel.deleteHabit(context);
                  }, icon: Icon(Icons.delete, color: const Color.fromARGB(255, 248, 90, 79),),tooltip: "Delete the habit",);
                }
              )
            ],
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: userHabit.imagePath,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
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
                  const SizedBox(height: 20),
                  Consumer<HabitDetailViewModel>(
                    builder: (context, viewModel, child) {
                      return StadiumSideBlueIconButton(
                          onPressed: () {
                            viewModel.startAiChat(context);
                          },
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageConstants.aiAvatar,
                                width: 24,
                                color: Colors.white,
                              ),
                              context.sized.emptySizedWidthBoxLow3x,
                              Baseline(
                                baseline: 20,
                                baselineType: TextBaseline.alphabetic,
                                child: Text(StringConstants.habitDetailPageChatWithAI, style: context.general.textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                              ),
                            ],
                          )
                      );
                    }
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
                            viewModel.fetchDoneHabitsForSpecificMonth(focusedDay);
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
        )
    );
  }
}