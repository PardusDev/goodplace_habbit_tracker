import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final ValueChanged<DateTime> onMonthChanged;
  final ValueChanged<DateTime> onDaySelected;
  final List<dynamic> Function(DateTime) eventLoader;

  const CalendarWidget({Key? key, required this.onDaySelected, required this.onMonthChanged, required this.eventLoader}) : super(key: key);
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _selectedDay = DateTime.now(); // Initialize with the current day
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                final today = DateTime.now();

                if (selectedDay.isAfter(today)) {
                  return;
                }

                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                widget.onDaySelected(selectedDay);
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
                widget.onMonthChanged(focusedDay);
              },
              eventLoader: (day) {
                final key = DateTime(day.year, day.month, day.day);
                return widget.eventLoader(key);
              },
              headerVisible: false,
              calendarStyle: const CalendarStyle(
                defaultTextStyle: TextStyle(color: Color(0xFF4d57c8)),
                weekendTextStyle: TextStyle(color: Color(0xFF4d57c8)),
                todayDecoration: BoxDecoration(
                  color: Color(0xFF4d57c8),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color.fromARGB(120, 77, 87, 200,),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(color: Colors.white),
                selectedTextStyle: TextStyle(color: Colors.white),
                markerDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Color(0xFF4d57c8)),
                weekendStyle: TextStyle(color: Color(0xFF4d57c8)),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final today = DateTime.now();

                  if (day.isAfter(DateTime(today.year, today.month, today.day))) {
                    return Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return null;
                },
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
