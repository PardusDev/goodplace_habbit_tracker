import 'package:flutter/foundation.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';

import '../../models/UserHabit.dart';
import '../../services/auth_service.dart';
import '../../services/habit_service.dart';

class CreateHabitModalViewModel extends ChangeNotifier with BaseViewModel {
  final _authService = AuthService();
  final _habitService = HabitService();


  // Add text controllers for the text fields

  void createHabit() {
    try {
      // Get the current user
      final user = _authService.getCurrentUser();

      // Get the text from the text controllers
      // Call the createHabitCollection method from the HabbitService
      UserHabit newHabit = UserHabit(habitId: '', title: 'asd', subject: 'qwt', imagePath: 'htt', createdAt: DateTime.now(), doneHabits: []
            // Pass the text from the text controllers
          );

      _habitService.addNewHabit(user!, newHabit);
    } catch (e) {
      throw e;
    }
  }

  void getUserHabits() async {
    final user = _authService.getCurrentUser();
    if (user != null) {
      final test = await _habitService.getUserHabits(user);
      print(test);
    } else {
      print('User not found.');
    }
  }
}