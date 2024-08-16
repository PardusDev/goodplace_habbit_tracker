import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/string_constants.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page_view_model.dart';
import 'package:goodplace_habbit_tracker/widgets/Drawer.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
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
              _buildStreakInfo(size),
              const SizedBox(height: 30),
              _buildIconCards(size),
              const SizedBox(height: 30),
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
                  return const Center(child: Text('Oh no! Here is empty'),);
                }

                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homePageViewModel.showAll
                      ? homePageViewModel.habits.length
                      : (homePageViewModel.habits.length > 3 ? 4 : homePageViewModel.habits.length),
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return context.sized.emptySizedHeightBoxLow;
                  },
                  // TODO: Improve image loading.
                  itemBuilder: (BuildContext context, int index) {
                    if (!homePageViewModel.showAll && index == 3) {
                      // Show "Show All" button as the last item if not showing all habits
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



 Widget _buildStreakInfo(Size size) {
  return Container(
    width: size.width * 0.9,
    height: 170,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      image: const DecorationImage(
        image: AssetImage("assets/images/Dots.png"), // Replace with your image asset
        fit: BoxFit.cover,
        alignment: Alignment(0, 0.5), // Move the image slightly downwards
      ),
    ),
    child: const Padding(
      padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "1 Day",
            style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Your current streak",
            style: TextStyle(
                color: Color.fromARGB(255, 80, 80, 80),
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "1 Day",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Text(
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


 Widget _buildIconCards(Size size) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImageCard(size, 'assets/icons/calendar.png', '1 Day', "Total perfect days"),
          const SizedBox(width: 20),
          _buildImageCard(size, 'assets/icons/check.png', '1 Day', "Total complete days"),
        ],
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImageCard(size, 'assets/icons/hype.png', '%100', "Habit completion rate"),
          const SizedBox(width: 20),
          _buildImageCard(size, 'assets/icons/stats.png', '1.01', "Average per daily"),
        ],
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
}
}