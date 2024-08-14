import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/string_constants.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page_view_model.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/color_constants.dart';
import '../../widgets/CustomShimmer.dart';
import '../../widgets/HabitListTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageViewModel _mainModel;

  @override
  void initState() {
    super.initState();
    _mainModel = Provider.of<HomePageViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _mainModel.getMotivasyon();
      await _mainModel.getUserInformation(context);
      await _mainModel.fetchHabits(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    _mainModel = Provider.of<HomePageViewModel>(context, listen: true);
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
      drawer: Drawer(
  backgroundColor: Colors.white,
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
   const   DrawerHeader(
        decoration: BoxDecoration(
          color:  Color.fromARGB(255, 77, 87, 200),
        ),
        child:  Text(
          StringConstants.appName,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      ListTile(
        title: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF4d57c8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              _mainModel.navigateToSettings();
            },
          ),
        ),
      ),
      const SizedBox(height: 24,),
      ListTile(
        title: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF4d57c8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              if (mounted) {
                _mainModel.signOut(context);
              }
            },
          ),
        ),
      )
    ],
  ),
),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCalendar(size),
              const SizedBox(height: 30),
              _buildMyHabits(size, _mainModel),
              const SizedBox(height: 30),
              _buildCard(size, _mainModel),
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

  Widget _buildCalendar(Size size) {
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              headerVisible: false,
              calendarStyle: const CalendarStyle(
                defaultTextStyle: TextStyle(color: Color(0xFF4d57c8)),
                weekendTextStyle: TextStyle(color: Color(0xFF4d57c8)),
                todayTextStyle: TextStyle(color: Colors.white),
                selectedTextStyle: TextStyle(color: Colors.white),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Color(0xFF4d57c8)),
                weekendStyle: TextStyle(color: Color(0xFF4d57c8)),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendItem(
                  icon: Icons.circle,
                  color: Color(0xFF4d57c8),
                  label: 'All Complete',
                ),
                SizedBox(width: 20),
                _LegendItem(
                  icon: Icons.circle_outlined,
                  color: Color(0xFF4d57c8),
                  label: 'Some Complete',
                ),
              ],
            ),
          ],
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
                  // TODO: Change this to shimmer
                  return const CustomShimmer(
                    width: double.infinity,
                    height: 24,
                  );
                }

                if (homePageViewModel.habits.isEmpty) {
                  return Center(child: Text('Oh no! Here is empty'),);
                }

                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homePageViewModel.habits.length,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return context.sized.emptySizedHeightBoxLow;
                  },
                  // TODO: Improve image loading.
                  itemBuilder: (BuildContext context, int index) {
                    print(homePageViewModel.checkHabitIsCompletedForSelectedDate(homePageViewModel.habits[index], DateTime.now()));
                    return HabitListTile(
                      title: homePageViewModel.habits[index].title,
                      imageUrl: 'https://www.theinspiringjournal.com/wp-content/uploads/2024/08/77-Morning-Motivational-Quotes-for-Success.jpg',
                      // TODO: Change isCompleted to real value
                      onPressed: () {
                        homePageViewModel.doneHabit(homePageViewModel.habits[index]);
                      },
                      // TODO: Change DateTime.now() to selected date
                      isCompleted: homePageViewModel.checkHabitIsCompletedForSelectedDate(homePageViewModel.habits[index], DateTime.now()),
                    );
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
          : CustomShimmer(width: double.infinity, height: 20),
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

class _LegendItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _LegendItem({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
