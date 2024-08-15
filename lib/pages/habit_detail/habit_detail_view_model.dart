import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';

import '../../managers/HabitManager.dart';
import '../../models/DoneHabit.dart';
import '../../models/UserHabit.dart';

class HabitDetailViewModel extends ChangeNotifier with BaseViewModel {
  final HabitManager _habitManager = HabitManager();

  UserHabit? _currentHabit;
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<DoneHabit>> _events = {};

  UserHabit? get currentHabit => _currentHabit;
  DateTime get selectedDay => _selectedDay;
  Map<DateTime, List<DoneHabit>> get events => _events;
  List<UserHabit> get habits => _habitManager.habits;

  set selectedDay(DateTime value) {
    _selectedDay = value;
    notifyListeners();
  }

  HabitDetailViewModel() {
    _habitManager.addListener(_onHabitsUpdated);
  }

  void _onHabitsUpdated() {
    notifyListeners();
  }

  void setCurrentHabit(UserHabit habit) {
    _currentHabit = habit;
    notifyListeners();
  }

  // For the calendar
  void prepareEvents() {
    _events = {};

    for (var doneHabit in currentHabit!.doneHabits) {
      DateTime date = DateTime(doneHabit.doneAt.year, doneHabit.doneAt.month, doneHabit.doneAt.day);

      if (_events[date] != null) {
        _events[date]!.add(doneHabit);
      } else {
        _events[date] = [doneHabit];
      }
    }
  }

  Future<void> fetchDoneHabitsForSpecificMonth(UserHabit userHabit, DateTime date) async {
    User? user = FirebaseAuth.instance.currentUser;
    await _habitManager.loadDoneHabitForSpecificMonth(user!.uid, userHabit.habitId, date.year, date.month);
    prepareEvents();
    notifyListeners();
  }

  bool checkHabitIsCompletedForSelectedDate(UserHabit habit) {
    return _habitManager.checkHabitIsCompletedForSelectedDate(habit, _selectedDay);
  }
}