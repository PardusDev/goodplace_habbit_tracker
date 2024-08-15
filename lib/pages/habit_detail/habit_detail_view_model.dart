import 'package:flutter/foundation.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';

import '../../managers/HabitManager.dart';
import '../../models/UserHabit.dart';

class HabitDetailViewModel extends ChangeNotifier with BaseViewModel {
  final HabitManager _habitManager = HabitManager();


  bool checkHabitIsCompletedForSelectedDate(UserHabit habit) {
    return _habitManager.checkHabitIsCompletedForSelectedDate(habit, DateTime.now());
  }
}