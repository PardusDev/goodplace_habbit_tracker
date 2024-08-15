import 'package:flutter/foundation.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';
import 'package:goodplace_habbit_tracker/init/navigation/navigation_service.dart';

import '../../managers/HabitManager.dart';

class ManageMyHabitsViewModel extends ChangeNotifier with BaseViewModel {
  final _navigationService = NavigationService.instance;
  final HabitManager _habitManager = HabitManager();

  get habits => _habitManager.habits;

  ManageMyHabitsViewModel(){
    _habitManager.addListener(notifyListeners);
  }

   void navigateToManageMyHabits(){
      _navigationService.navigateToPage('/habitDetail', null);
    }
}