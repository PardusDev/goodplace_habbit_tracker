import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/string_constants.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page_view_model.dart';
import 'package:goodplace_habbit_tracker/widgets/Drawer.dart';
import 'package:goodplace_habbit_tracker/widgets/ExpandableFAB.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../constants/image_constants.dart';
import '../../widgets/Calendar.dart';
import '../../widgets/CustomShimmer.dart';
import '../../widgets/HabitListTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageViewModel _homeModel;

  @override
  void initState() {
    super.initState();
    _homeModel = Provider.of<HomePageViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _homeModel.getMotivasyon();
      await _homeModel.getUserInformation(context);
      await _homeModel.fetchHabits(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    _homeModel = Provider.of<HomePageViewModel>(context, listen: true);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 77, 87, 200),
      appBar: AppBar(
        title: const Text('Home Page', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 100,
      ),
      drawer: MyDrawer(mainModel: _homeModel, currentPage:"Home Page"),
      floatingActionButton: ExpandableFAB(
        message: _homeModel.aiFabMessage,
        icon: Image.asset(
          ImageConstants.aiAvatar,
          color: Colors.white,
          width: 32,
        ),
        onPressed: () {
          _homeModel.showAiChatModal(context);
        },
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: size.width * 0.9,
                  child: Text(
                    _homeModel.greeting,
                    style:const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    textAlign: TextAlign.start,
                  )),
              const SizedBox(height: 15),
              CalendarWidget(
                onDaySelected: (selectedDay) {
                  _homeModel.setSelectedDate(context, selectedDay);
                },
                onMonthChanged: (focusedDay) {

                },
                eventLoader: (day) {
                  return [];
                },
              ),
              const SizedBox(height: 30),
              _buildMyHabits(size, _homeModel),
              const SizedBox(height: 30),
              _buildCard(size, _homeModel),
              const SizedBox(height: 30),
              _buildInfoCard(size),
              const SizedBox(height: 30),
             /* _buildIconCards(size),
              const SizedBox(height: 30),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyHabits(Size size, HomePageViewModel _mainModel) {
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: ColorConstants.homePageCardBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: context.padding.normal,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(StringConstants.myHabits, style: context.general.textTheme.headlineSmall!.copyWith(
                color: ColorConstants.homePageCardTitleColor,
                fontWeight: FontWeight.w500
              )),
              SizedBox(
                height: 26,
                child: ElevatedButton(
                  onPressed: () {
                    _mainModel.showCreateHabitModal(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: ColorConstants.homePageAddHabbitButtonBackgroundColor,
                  ),
                  child: const Icon(
                      Icons.add,
                      color: ColorConstants.homePageAddHabbitButtonIconColor
                  ),
                ),
              ),
            ],
          ),

          context.sized.emptySizedHeightBoxLow3x,

          Consumer<HomePageViewModel>(
              builder: (context, homePageViewModel, child) {
                if (homePageViewModel.habitsIsLoading) {
                  return const CustomShimmer(
                    width: double.infinity,
                    height: 24,
                  );
                }

                if (homePageViewModel.habits.isEmpty) {
                  return const Center(child: Text(StringConstants.homePageHabitListIsEmpty),);
                }

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: ListView.separated(
                    key: ValueKey<bool>(homePageViewModel.showAll),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homePageViewModel.showAll
                        ? homePageViewModel.habits.length
                        : (homePageViewModel.habits.length > 3 ? 4 : homePageViewModel.habits.length),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return context.sized.emptySizedHeightBoxLow;
                    },
                    itemBuilder: (BuildContext context, int index) {
                      if (!homePageViewModel.showAll && index == 3) {
                        return TextButton(
                          onPressed: () {
                            homePageViewModel.toggleShowAll();
                          },
                          child: Text(StringConstants.homePageHabitListTileShowAllText, style: context.general.textTheme.titleMedium!.copyWith(
                              color: ColorConstants.homePageHabitListShowAllTextColor,
                            )
                          ),
                        );
                      } else {
                        final isCompleted = homePageViewModel.checkHabitIsCompletedForSelectedDate(homePageViewModel.habits[index]);

                        return HabitListTile(
                          title: homePageViewModel.habits[index].title,
                          imageUrl: homePageViewModel.habits[index].imagePath,
                          onTap: () {
                            homePageViewModel.navigateToHabitDetail(homePageViewModel.habits[index]);
                          },
                          onButtonPressed: () {
                            homePageViewModel.toggleHabit(context, homePageViewModel.habits[index], isCompleted);
                          },
                          isCompleted: isCompleted,
                        );
                      }

                    },
                  ),
                );
              }
          )
        ],
      ),
    );
  }

 Widget _buildCard(Size size, HomePageViewModel _mainModel) {
  return Container(
    width: size.width * 0.9,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: _mainModel.motivasyon.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
              child: Text(
                _mainModel.motivasyon,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(0xFF4d57c8), fontWeight: FontWeight.bold, fontSize: 15),
              ),
            )
          : const CustomShimmer(width: double.infinity, height: 20),
    ),
  );
}



Widget _buildInfoCard(Size size) {
  return Container(
    width: size.width * 0.9,
    height: 170,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Consumer<HomePageViewModel>(
        builder: (context, viewModel, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildInfo(size, ImageConstants.icFlame, viewModel.maxStreak.toString(), StringConstants.homePageCardMaxStreakTitle),
            const  Padding(
                padding:  EdgeInsets.symmetric(vertical:20.0),
                child:  VerticalDivider(color: Colors.grey, thickness: 1, width: 20),
              ),
              _buildInfo(size, ImageConstants.icHype, viewModel.todayCompletedHabits.toString(), StringConstants.homePageCardTodayCompletedHabitsTitle),
              const Padding(
                padding:  EdgeInsets.symmetric(vertical:20.0),
                child:  VerticalDivider(color: Colors.grey, thickness: 1, width: 20),
              ),
              _buildInfo(size, ImageConstants.icStats, viewModel.habits.length.toString(), StringConstants.homePageCardTotalHabitsTitle),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildInfo(Size size, String imagePath, String text, String textdesc) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
const Spacer(), // Pushes the content down to the center
       const SizedBox(height: 20,),
        Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 0.4,
              child: Image.asset(imagePath, height: 60, width: 60, fit: BoxFit.contain),
            ),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF4d57c8),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      const  SizedBox(height: 10,),
        SizedBox(
          height: 30, // Fixed height to ensure consistent top alignment
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              textdesc,
              style: const TextStyle(
                color: Color(0xFF575757),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
     const   Spacer(), // Pushes the content down to the center
      ],
    ),
  );
}





/*
 Widget _buildIconCards(Size size) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Consumer<HomePageViewModel>(
        builder: (context, viewModel, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImageCard(size, ImageConstants.icFlame, viewModel.maxStreak.toString(), StringConstants.homePageCardMaxStreakTitle),
              const SizedBox(width: 20),
              _buildImageCard(size, ImageConstants.icStats, viewModel.habits.length.toString(), StringConstants.homePageCardTotalHabitsTitle),
            ],
          );
        }
      ),
      const SizedBox(height: 20),
      Consumer<HomePageViewModel>(
        builder: (context, viewModel, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImageCard(size, ImageConstants.icHype, viewModel.todayCompletedHabits.toString(), StringConstants.homePageCardTodayCompletedHabitsTitle),
              const SizedBox(width: 20),
              // TODO: For a while we are hiding this card.
              Opacity(opacity: 0, child: _buildImageCard(size, ImageConstants.icStats, '1.01', "Average per daily")),
            ],
          );
        }
      ),
    ],
  );
}

Widget _buildImageCard(Size size, String imagePath, String text, String textdesc) {
  return Container(
    width: (size.width * 0.9 - 20) / 2,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath, height: 25, width: 25, fit: BoxFit.contain,),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
                color: Color(0xFF4d57c8),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            textdesc,
            style: const TextStyle(
                color: Color(0xFF575757),
                fontSize: 11,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
  );
}*/
}