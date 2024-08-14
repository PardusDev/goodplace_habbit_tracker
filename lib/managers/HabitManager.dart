import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/models/DoneHabit.dart';

import '../constants/string_constants.dart';
import '../models/UserHabit.dart';
import '../services/habit_service.dart';

class HabitManager with ChangeNotifier {
  final HabitService _habitService = HabitService();


  static List<UserHabit> _habits = [];


  List<UserHabit> get habits => _habits;

  Future<void> loadUserHabits(String uid) async {
    try {
      _habits = await _habitService.getUserHabits(uid);
      // Run loadDoneHabitForSpecificDay for each habit
      for (var habit in _habits) {
        // TODO: Change DateTime.now() to a specific date (get it from the calendar)
        final doneHabit = await loadDoneHabitForSpecificDay(uid, habit.habitId, DateTime.now());
        if (doneHabit != null) {
          habit.doneHabits.add(doneHabit);
        }
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<DoneHabit?> loadDoneHabitForSpecificDay(String uid, String habitId, DateTime date) async {
    try {
      final doneHabit = await _habitService.getDoneHabitForSpecificDay(uid, habitId, date);
      if (doneHabit == null) {
        return null;
      }
      return doneHabit;
    } catch (e) {
      throw e;
    }
  }

  Future<void> addHabit(User user, UserHabit habit) async {
    try {
      final habitId = await _habitService.addNewHabit(user, habit);
      if (habitId == null) {
        throw Exception(StringConstants.anErrorOccured);
      }
      habit.habitId = habitId;
      _habits.add(habit);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addDoneHabit(User user, DoneHabit doneHabit) async {
    try {
      final doneHabitId = await _habitService.addDoneHabit(user, doneHabit);
      if (doneHabitId == null) {
        throw Exception(StringConstants.anErrorOccured);
      }
      if (_habits.any((element) => element.habitId == doneHabit.habitId)) {
        _habits.firstWhere((element) => element.habitId == doneHabit.habitId).doneHabits.add(doneHabit);
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeDoneHabit(User user, DoneHabit doneHabit) async {
    try {
      final result = await _habitService.deleteDoneHabit(user, doneHabit);
      if (!result) {
        throw Exception(StringConstants.anErrorOccured);
      }
      if (_habits.any((element) => element.habitId == doneHabit.habitId)) {
        _habits.firstWhere((element) => element.habitId == doneHabit.habitId).doneHabits.removeWhere((existingHabit) => existingHabit.id == doneHabit.id);
      }
      notifyListeners();
    } catch (e) {
      // Don't need to move StringConstants to a separate file.
      throw "An error occured while removing the done habit.";
    }
  }
}