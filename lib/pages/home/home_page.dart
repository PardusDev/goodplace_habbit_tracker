import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mainModel.getMotivasyon();
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
      drawer: const Drawer(
        backgroundColor: Color.fromARGB(255, 77, 87, 200),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCalendar(size),
              const SizedBox(height: 30),
              _buildCard(size, 120, _mainModel),
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

  Widget _buildCard(Size size, double height, HomePageViewModel _mainModel) {
  return Container(
    width: size.width * 0.9,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: _mainModel.motivasyon.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _mainModel.motivasyon,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(0xFF4d57c8), fontWeight: FontWeight.bold),
              ),
            )
          : Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: size.width * 0.9, // Match the width of the outer container
                height: height, // Match the height of the outer container
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20), // Match the border radius
                ),
              ),
            ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIconCard(
            size, Icons.calendar_today, '1 Day', Color.fromARGB(255, 255, 184, 184)),
        const SizedBox(width: 20),
        _buildIconCard(
            size, Icons.check, '1 Day', Color.fromARGB(255, 220, 241, 153)),
      ],
    );
  }

  Widget _buildIconCard(Size size, IconData icon, String text, Color iconColor) {
    return Container(
      width: (size.width * 0.9 - 20) / 2,
      height: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 35),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                  color: Color(0xFF4d57c8),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
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
