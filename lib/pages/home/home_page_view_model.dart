import 'dart:async';

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
  String greeting = "";
  final NavigationService _navigationService = NavigationService.instance;
  final AuthService _authService = AuthService();
  final HabitManager _habitManager = HabitManager();
  Timer? _timer; // Timer to update greeting message periodically

  bool _habitsIsLoading = false;

  List<UserHabit> get habits => _habitManager.habits;
  bool get habitsIsLoading => _habitsIsLoading;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  HomePageViewModel() {
    getGreetingMessage();
    startGreetingUpdateTimer(); // Start the timer when the ViewModel is created
    _habitManager.addListener(_onHabitsUpdated);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

  getGreetingMessage() {
    final hour = DateTime.now().hour;


    if (hour >= 4 && hour < 12) {
      greeting = "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      greeting = "Good Afternoon";
    } else if (hour >= 17 && hour < 21) {
      greeting = "Good Evening";
    } else {
      greeting = "Good Night";
    }

    greeting = greeting + " X";
    notifyListeners();
  }
  void startGreetingUpdateTimer() {
    //_timer = Timer.periodic(Duration(minutes: 1), (timer) {
     // getGreetingMessage();
    //});
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

  void toggleHabit(UserHabit habit, bool isCompleted) async {
    try {
      final firebaseUser = _authService.getCurrentUser();
      DoneHabit doneHabit = DoneHabit(
          id: generateIdFromDate(DateTime.now()),
          habitId: habit.habitId,
          doneAt: DateTime.now()
      );
      if (isCompleted) {
        await _habitManager.removeDoneHabit(firebaseUser!, doneHabit);
      } else {
        await _habitManager.addDoneHabit(firebaseUser!, doneHabit);
      }
      // TODO: Show a success message
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  /// This function checks if the habit is completed for the selected date. And returns true if it is completed.
  bool checkHabitIsCompletedForSelectedDate(UserHabit habit, DateTime selectedDate) {
    final convertedDateId = generateIdFromDate(selectedDate);
    return habit.doneHabits.any((element) => element.id == convertedDateId);
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
      throw e;
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