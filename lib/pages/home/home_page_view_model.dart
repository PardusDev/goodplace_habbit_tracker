import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/init/navigation/navigation_service.dart';
import 'package:goodplace_habbit_tracker/locator.dart';
import 'package:goodplace_habbit_tracker/pages/ai_chat/ai_chat_page.dart';
import 'package:goodplace_habbit_tracker/pages/create_habit/create_habit_modal.dart';
import 'package:goodplace_habbit_tracker/repository/repository.dart';
import 'package:goodplace_habbit_tracker/utilities/generate_id_from_date.dart';
import 'package:goodplace_habbit_tracker/widgets/SuccessSplashBox.dart';
import 'package:provider/provider.dart';

import '../../managers/AppUserManager.dart';
import '../../managers/HabitManager.dart';
import '../../models/DoneHabit.dart';
import '../../models/UserHabit.dart';
import '../../services/auth_service.dart';
import '../../utilities/normalize_date.dart';
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
  final AppUserManager _appUserManager = AppUserManager();
  final HabitManager _habitManager = HabitManager();
  bool _aiFabExpanded = false;
  String _aiFabMessage = "";

  bool _showAll = false;
  bool _habitsIsLoading = false;
  DateTime _selectedDate = DateTime.now();


  List<UserHabit> get habits => _habitManager.habits;
  get showAll => _showAll;
  bool get habitsIsLoading => _habitsIsLoading;
  DateTime get selectedDate => _selectedDate;
  bool get aiFabExpanded => _aiFabExpanded;
  String get aiFabMessage => _aiFabMessage;

  void setSelectedDate(BuildContext buildContext, DateTime value) {
    if (value == _selectedDate) return;
    _selectedDate = value;
    fetchHabits(buildContext);
    notifyListeners();
  }

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  void toggleShowAll() {
    _showAll = !_showAll;
    notifyListeners();
  }


  void toggleAIExpand() {
    _aiFabExpanded = !_aiFabExpanded;
    notifyListeners();
  }

  void setAIExpand(bool value) {
    _aiFabExpanded = value;
    notifyListeners();
  }

  void setAIExpandMessage(String message) {
    _aiFabMessage = message;
    notifyListeners();
  }

  HomePageViewModel() {
    getGreetingMessage();
    showAIMessage();
    _appUserManager.addListener(_onUserUpdated);
    _habitManager.addListener(_onHabitsUpdated);
  }

  void showAIMessage() {
    Timer(const Duration(milliseconds: 1500), () {
      setAIExpandMessage("Can't find a habit to pick up? I can help!");
      setAIExpand(true);

      Timer(const Duration(milliseconds: 6000), () {
        setAIExpand(false);
      });
    });
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

    if (_appUserManager.appUser != null) {
      greeting = greeting + " " + _appUserManager.appUser!.name + "!";
    } else {
      greeting = greeting + " Guest!";
    }

    notifyListeners();
  }

  void _onHabitsUpdated() {
    notifyListeners();
  }

  void _onUserUpdated() {
    notifyListeners();
    getGreetingMessage();
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
      await _habitManager.loadUserHabits(firebaseUser!.uid, selectedDate);
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

  void toggleHabit(BuildContext buildContext, UserHabit habit, bool isCompleted) async {
    try {
      final firebaseUser = _authService.getCurrentUser();
      DoneHabit doneHabit = DoneHabit(
          id: generateIdFromDate(_selectedDate),
          habitId: habit.habitId,
          doneAt: _selectedDate
      );

      /*
      TODO: We are not blocking the user from marking habits for the future.
            We will implement this feature in the future.
      // Block if the selected date is not today
      if (_selectedDate != DateTime.now()) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            errorSnackBar(
                "You can only mark habits for today."
            )
        );
        return;
      }
      */

      // Block if the selected date is past
      DateTime normalizedToday = normalizeDate(DateTime.now());
      DateTime normalizedSelectedDate = normalizeDate(_selectedDate);
      if (normalizedSelectedDate.isBefore(normalizedToday)) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            errorSnackBar(
                "You can't mark habits for the past."
            )
        );
        return;
      }

      if (isCompleted) {
        /*
        TODO: This function currently out of use. It will be used in the future.
                The out of use reason is that the function is not working properly with Streak.
        showDialog(
            context: buildContext,
            builder: (BuildContext context) {
              return const ConfirmAlertDialog(
                  title: StringConstants.habitAlertDialogTitle,
                  body: StringConstants.habitAlertDialogBody
              );
            }
        ) .then((value) async {
          if (value == true) {
            await _habitManager.removeDoneHabit(firebaseUser!, doneHabit);
          }
        });
         */
      } else {
        showDialog(
            context: buildContext,
            builder: (BuildContext context) {
              return const SuccessSplashBox(

              );
            }
        );
        await _habitManager.addDoneHabit(firebaseUser!, habit, doneHabit);
      }
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(_navigationService.navigatorKey.currentContext!).showSnackBar(
          errorSnackBar(
              e.toString()
          )
      );
    }
  }

  /// This function checks if the habit is completed for the selected date. And returns true if it is completed.
  bool checkHabitIsCompletedForSelectedDate(UserHabit habit) {
    return _habitManager.checkHabitIsCompletedForSelectedDate(habit, selectedDate);
  }

  /// Get user details from Firebase and set it to AppUserManager
  Future<void> getUserInformation(BuildContext buildContext) async {
    try {
      User? firebaseUser = _authService.getCurrentUser();
      await _authService.getUserByUID(firebaseUser!.uid).then((value) {
        // Set user to AppUserManager
        _appUserManager.setUser(value!);
      });
      notifyListeners();
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
    _navigationService.navigateToPage('/settings', null).then((_) => notifyListeners());
  }

  void navigateToManageMyHabits(){
    _navigationService.navigateToPage('/manageMyHabits', null).then((_) => notifyListeners());
  }

  void navigateToHome(){
    _navigationService.navigateToPage('/home', null).then((_) => notifyListeners());
  }

  void navigateToHabitDetail(UserHabit habit) {
    _navigationService.navigateToPage('/habitDetail', habit).then((_) => notifyListeners());
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

  void showAiChatModal(BuildContext buildContext) {
    showModalBottomSheet(
        context: buildContext,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const AiChatPage();
        }
    ).then((value) => notifyListeners());
  }
}