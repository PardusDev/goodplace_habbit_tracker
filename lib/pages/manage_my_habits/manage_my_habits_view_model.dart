import 'package:flutter/foundation.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';
import 'package:goodplace_habbit_tracker/init/navigation/navigation_service.dart';

import '../../managers/HabitManager.dart';
import '../../models/UserHabit.dart';

class ManageMyHabitsViewModel extends ChangeNotifier with BaseViewModel {
  final _navigationService = NavigationService.instance;

  final HabitManager _habitManager = HabitManager();
  int _selectedSortOption = -1;

  get habits => _habitManager.habits;
  int get selectedSortOption => _selectedSortOption;

  set selectedSortOption(int value) {
    _selectedSortOption = value;
    switch (value) {
      case 0:
        _habitManager.sortByCreationDate();
        break;
      case 1:
        _habitManager.sortByMaxStreak();
        break;
      default:
        _habitManager.sortByCreationDate();
    }
    notifyListeners();
  }

  ManageMyHabitsViewModel(){
    _habitManager.addListener(notifyListeners);
  }

  // region Sort methods
  void sortHabitsByCreationDate() {
    _habitManager.sortByCreationDate();
  }

  void sortHabitsByMaxStreak() {
    _habitManager.sortByMaxStreak();
  }
  // endregion

 void navigateToManageMyHabits(UserHabit userHabit){
    _navigationService.navigateToPage('/habitDetail', userHabit).then((_) {
      notifyListeners();
    });
  }
}