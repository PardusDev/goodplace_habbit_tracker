import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/models/DoneHabit.dart';

import '../constants/string_constants.dart';
import '../models/UserHabit.dart';
import '../services/habit_service.dart';
import '../utilities/generate_id_from_date.dart';

class HabitManager with ChangeNotifier {
  final HabitService _habitService = HabitService();


  static List<UserHabit> _habits = [];


  List<UserHabit> get habits => _habits;

  Future<void> loadUserHabits(String uid, DateTime dateTime) async {
    try {
      _habits = await _habitService.getUserHabits(uid);
      for (var habit in _habits) {
        final doneHabit = await loadDoneHabitForSpecificDay(uid, habit.habitId, dateTime);

        // If doneHabit exist in the list don't add it again.
        if (doneHabit != null && !habit.doneHabits.any((dh) => dh.id == doneHabit.id)) {
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

  Future<bool> loadDoneHabitForSpecificMonth(String uid, String habitId, int year, int month) async {
    try {
      final doneHabits = await _habitService.getDoneHabitsForSpecificMonth(uid, habitId, year, month);
      // Replace doneHabits with the existing doneHabits.
      _habits.firstWhere((element) => element.habitId == habitId).doneHabits.clear();
      // Add all doneHabits to the existing doneHabits.
      _habits.firstWhere((element) => element.habitId == habitId).doneHabits.addAll(doneHabits);
      notifyListeners();
      return true;
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

  Future<void> addDoneHabit(User user, UserHabit userHabit, DoneHabit doneHabit) async {
    try {
      final doneHabitId = await _habitService.addDoneHabit(user, doneHabit);
      if (doneHabitId == null) {
        throw Exception(StringConstants.anErrorOccured);
      }
      if (_habits.any((element) => element.habitId == doneHabit.habitId)) {
        _habits.firstWhere((element) => element.habitId == doneHabit.habitId).doneHabits.add(doneHabit);
      }
      checkAndUpdateHabitStreak(user, userHabit, doneHabit);
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

  Future<void> updateHabit(User user, UserHabit habit) async {
    try {
      final result = await _habitService.updateHabit(user, habit);
      if (!result) {
        throw Exception(StringConstants.anErrorOccured);
      }
      final index = _habits.indexWhere((element) => element.habitId == habit.habitId);
      if (index != -1) {
        _habits[index] = habit;
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  /// This method checks if the habit is completed for the selected date.
  /// With that, updates the current streak, max streak, and current streak last date.
  Future<void> checkAndUpdateHabitStreak(User user, UserHabit userHabit, DoneHabit doneHabit) async {
    final lastDate = userHabit.currentStreakLastDate;
    if (userHabit.currentStreakLastDate == null) {
      // This means the user has never completed the habit. So, the streak is 0.
      // Update the max streak, current streak, and current streak last date.
      userHabit.currentStreak = 1;
      userHabit.maxStreak = userHabit.currentStreak;
      userHabit.currentStreakLastDate = doneHabit.doneAt;
      await updateHabit(user, userHabit);
      return;
    }

    final difference = doneHabit.doneAt.difference(lastDate!);
    if (difference.inDays <= 1) {
      // This means the user has completed the habit yesterday.
      // Update the current streak and current streak last date.
      userHabit.currentStreak += 1;
      userHabit.currentStreakLastDate = doneHabit.doneAt;
      if (userHabit.currentStreak > userHabit.maxStreak) {
        // Update the max streak if the current streak is greater than the max streak.
        userHabit.maxStreak = userHabit.currentStreak;
      }
      await updateHabit(user, userHabit);
      return;
    } else if (difference.inDays > 1) {
      // This means the user has not completed the habit yesterday.
      // Update the current streak to 1 and current streak last date to today.
      userHabit.currentStreak = 1;
      userHabit.currentStreakLastDate = doneHabit.doneAt;
      await updateHabit(user, userHabit);
      return;
    }

    await updateHabit(user, userHabit);
    return;
  }

  bool checkHabitIsCompletedForSelectedDate(UserHabit habit, DateTime dateTime) {
    final convertedDateId = generateIdFromDate(dateTime);
    return habit.doneHabits.any((element) => element.id == convertedDateId);
  }
}