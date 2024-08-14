import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/init/navigation/navigation_service.dart';
import 'package:goodplace_habbit_tracker/locator.dart';
import 'package:goodplace_habbit_tracker/pages/create_habit/create_habit_modal.dart';
import 'package:goodplace_habbit_tracker/repository/repository.dart';
import 'package:goodplace_habbit_tracker/utilities/generate_id_from_date.dart';
import 'package:provider/provider.dart';

import '../../managers/AppUserManager.dart';
import '../../managers/HabitManager.dart';
import '../../models/DoneHabit.dart';
import '../../models/UserHabit.dart';
import '../../services/auth_service.dart';
import '../../widgets/Snackbars.dart';

enum ViewState { geliyor, geldi, hata }

class HomePageViewModel with ChangeNotifier {
  final Repository _repository = locator<Repository>();
  ViewState _state = ViewState.geliyor;
  ViewState get state => _state;
  String motivasyon="";
  final NavigationService _navigationService = NavigationService.instance;
  final AuthService _authService = AuthService();
  final HabitManager _habitManager = HabitManager();

  bool _habitsIsLoading = false;

  List<UserHabit> get habits => _habitManager.habits;
  bool get habitsIsLoading => _habitsIsLoading;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  HomePageViewModel() {
    _habitManager.addListener(_onHabitsUpdated);
  }

  void _onHabitsUpdated() {
    notifyListeners();
  }

  getMotivasyon()async {
    try {
      motivasyon = await _repository.getMotivasyon();
    } catch (e) {
      // Maybe we can get motivation from local storage
      motivasyon = e.toString();
    } finally {
      notifyListeners();
    }
  }


  Future<void> fetchHabits(BuildContext buildContext) async {
    try {
      _habitsIsLoading = true;
      notifyListeners();
      final firebaseUser = _authService.getCurrentUser();
      await _habitManager.loadUserHabits(firebaseUser!.uid);
      _habitsIsLoading = false;
      notifyListeners();
    } catch (e) {
      _habitsIsLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(buildContext).showSnackBar(
          errorSnackBar(
              e.toString()
          )
      );
    }
  }

  void doneHabit(UserHabit habit) async {
    try {
      final firebaseUser = _authService.getCurrentUser();
      DoneHabit doneHabit = DoneHabit(
          id: generateIdFromDate(DateTime.now()),
          habitId: habit.habitId,
          doneAt: DateTime.now()
      );
      await _habitManager.addDoneHabit(firebaseUser!, doneHabit);
      notifyListeners();
      return;
    } catch (e) {
      return;
    }
  }

  /// Get user details from Firebase and set it to AppUserManager
  Future<void> getUserInformation(BuildContext buildContext) async {
    try {
      User? firebaseUser = _authService.getCurrentUser();
      await _authService.getUserByUID(firebaseUser!.uid).then((value) {
        // Set user to AppUserManager
        Provider.of<AppUserManager>(buildContext, listen: false).setUser(value!);
      });
    } catch (e) {
      // TODO: Handle this error
      print(e);
    }
  }

  void signOut(BuildContext buildContext) async {
    try {
      await _authService.signOut();
      _navigationService.navigateToPageClear("/welcome", null);
      Provider.of<AppUserManager>(buildContext, listen: false).clearUser();
    } catch (e) {
      ScaffoldMessenger.of(buildContext).showSnackBar(
          errorSnackBar(
              e.toString()
          )
      );
    }
  }

  void navigateToSettings() {
    _navigationService.navigateToPage('/settings', null);
  }

  void showCreateHabitModal(BuildContext buildContext) {
    showModalBottomSheet(
        context: buildContext,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const CreateHabitModal();
        }
    ).then((value) => notifyListeners());
  }
}