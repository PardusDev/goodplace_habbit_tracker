import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';

import '../../models/UserHabit.dart';
import '../../services/auth_service.dart';
import '../../services/habit_service.dart';

class CreateHabitModalViewModel extends ChangeNotifier with BaseViewModel {
  final _authService = AuthService();
  final _habitService = HabitService();

  // Add text controllers for the text fields

  void createHabit() async {
    User? user = await _authService.getCurrentUser();
    final userId = user!.uid;
    // Get the text from the text controllers
    // Call the createHabitCollection method from the HabbitService
    UserHabit newHabit = UserHabit(habitId: '', title: 'asd', subject: 'qwt', imagePath: 'htt', createdAt: DateTime.now(), doneHabits: []
      // Pass the text from the text controllers
    );

    _habitService.addNewHabit(userId, newHabit);
  }
}