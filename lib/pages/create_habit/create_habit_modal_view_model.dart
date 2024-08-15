import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';
import 'package:goodplace_habbit_tracker/managers/HabitManager.dart';

import '../../constants/string_constants.dart';
import '../../init/navigation/navigation_service.dart';
import '../../models/UserHabit.dart';
import '../../services/auth_service.dart';

class CreateHabitModalViewModel extends ChangeNotifier with BaseViewModel {
  final _authService = AuthService();
  final _habitManager = HabitManager();
  final _navigationService = NavigationService.instance;

  String _errorText = '';
  bool _titleValid = false;

  final _titleController = TextEditingController();
  final _subjectController = TextEditingController();
  final _imagePathController = TextEditingController();

  String get errorText => _errorText;
  bool get titleValid => _titleValid;

  TextEditingController get titleController => _titleController;
  TextEditingController get subjectController => _subjectController;
  TextEditingController get imagePathController => _imagePathController;

  void onTitleChanged(String title) {
    if (title.isNotEmpty) {
      _titleValid = true;
    } else {
      _titleValid = false;
    }
    notifyListeners();
  }



  // Add text controllers for the text fields

  Future<void> createHabit() async {
    if (!_titleValid) {
      setErrorText(StringConstants.habitNameEmptyError);
      return;
    }

    try {
      // Get the current user
      final user = _authService.getCurrentUser();

      // Get the text from the text controllers
      UserHabit newHabit = UserHabit(
          habitId: '',
          title: titleController.text,
          subject: subjectController.text,
          imagePath: imagePathController.text,
          createdAt: DateTime.now(),
          doneHabits: [],
          maxStreak: 0,
          currentStreakLastDate: null,
          currentStreak: 0
      );

      await _habitManager.addHabit(user!, newHabit);

      notifyListeners();

      // Close the modal
      _navigationService.navigateToBack();
    } catch (e) {
      throw e;
    }
  }

  void setErrorText(String errorText) {
    _errorText = errorText;
    notifyListeners();
  }
}