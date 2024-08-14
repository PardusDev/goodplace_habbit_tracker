import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      print(_habits.length);
      _habits.add(habit);
      print(_habits.length);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}