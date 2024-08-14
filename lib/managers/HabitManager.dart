import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/string_constants.dart';
import '../models/UserHabit.dart';
import '../services/habit_service.dart';

class HabitManager extends ChangeNotifier {
  final HabitService _habitService = HabitService();
  List<UserHabit> _habits = [];


  List<UserHabit> get habits => _habits;

  Future<void> loadUserHabits(String uid) async {
    try {
      _habits = await _habitService.getUserHabits(uid);
      notifyListeners();
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
}