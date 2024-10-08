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
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../constants/string_constants.dart';
import '../../managers/AppUserManager.dart';
import '../../managers/HabitManager.dart';
import '../../models/DoneHabit.dart';
import '../../models/UserHabit.dart';
import '../../services/auth_service.dart';
import '../../services/notification_service.dart';
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
  final AppUserManager _appUserManager = AppUserManager.instance;
  final HabitManager _habitManager = HabitManager();
  final NotificationService _notificationService = NotificationService();
  bool _aiFabExpanded = false;
  String _aiFabMessage = "";
  int _maxStreak = 0;
  int _todayCompletedHabits = 0;

  bool _showAll = false;
  bool _habitsIsLoading = false;
  DateTime _selectedDate = DateTime.now();


  List<UserHabit> get habits => _habitManager.habits;
  get showAll => _showAll;
  bool get habitsIsLoading => _habitsIsLoading;
  DateTime get selectedDate => _selectedDate;
  bool get aiFabExpanded => _aiFabExpanded;
  String get aiFabMessage => _aiFabMessage;
  int get maxStreak => _maxStreak;
  int get todayCompletedHabits => _todayCompletedHabits;

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

  void updateMaxStreak() {
    _maxStreak = habits.fold(0, (previousValue, element) => element.maxStreak > previousValue ? element.maxStreak : previousValue);
  }

  void updateTodayCompletedHabits() {
    _todayCompletedHabits = 0;

    String todayId = generateIdFromDate(selectedDate);

    for (var habits in habits) {
      for (var element in habits.doneHabits) {
        if (element.id == todayId) {
          _todayCompletedHabits++;
        }
      }
    }
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
    updateMaxStreak();
    updateTodayCompletedHabits();
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
      bool permissionGranted = await _showNotificationPermissionDialog();
      if (permissionGranted) {
        await _notificationService.cancelAllNotifications();
        for (var element in _habitManager.habits) {
          if (element.reminderTime != null) {
            await _notificationService.scheduleDailyNotification(element);
          }
        }
      }
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

  void reCalculateCards() {
    updateMaxStreak();
    updateTodayCompletedHabits();

    notifyListeners();
  }

  void toggleHabit(BuildContext buildContext, UserHabit habit, bool isCompleted) async {
    try {
      final firebaseUser = _authService.getCurrentUser();
      UserHabit nonUpdatedHabit = habit.copyWith();
      DoneHabit doneHabit = DoneHabit(
          id: generateIdFromDate(_selectedDate),
          habitId: habit.habitId,
          doneAt: _selectedDate
      );

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

      if (normalizedSelectedDate.isAfter(normalizedToday)) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            errorSnackBar(
                "You can't mark habits for the future."
            )
        );
        return;
      }

      if (!isCompleted) {
        await _habitManager.addDoneHabit(firebaseUser!, habit, doneHabit);
        showDialog(
            context: buildContext,
            builder: (BuildContext context) {
              return SuccessSplashBox(
                onPressed: () {
                  ScaffoldMessenger.of(buildContext).showSnackBar(
                    SnackBar(
                      content: const Text(StringConstants.successUndoText),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () async {
                          // Undo the action here
                          await _habitManager.undoDoneHabit(firebaseUser, habit, doneHabit, nonUpdatedHabit);

                          // Update the state and notify listeners
                          notifyListeners();
                        },
                      ),
                    ),
                  );
                },
              );
            }
        );
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
    _navigationService.navigateToPage('/manageMyHabits', null).then((_) {
      reCalculateCards();
      notifyListeners();
    });
  }

  void navigateToHome(){
    _navigationService.navigateToPage('/home', null).then((_) => notifyListeners());
  }

  void navigateToHabitDetail(UserHabit habit) {
    _navigationService.navigateToPage('/habitDetail', habit).then((_) {
      reCalculateCards();
      notifyListeners();
    });
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
          return const AiChatPage(userHabit: null);
        }
    ).then((value) => notifyListeners());
  }

  // Request permission for notifications
  Future<void> requestPermissionForNotifications() async {
    // Request permission for notifications
    if (await Permission.notification.isGranted) return;
    await [
      Permission.notification,
    ].request();
  }

  Future<void> requestAlarmPermission() async {
    // Request permission for alarm
    if (await Permission.scheduleExactAlarm.isGranted) return;
    await [
      Permission.scheduleExactAlarm,
    ].request();
  }

  Future<bool> _showNotificationPermissionDialog() async {
    if (await Permission.notification.isGranted) return true;
    bool? result = await showDialog<bool>(
      context: _navigationService.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text('Need Notification Permission'),
          content: Text(
            'To ensure full functionality of the application, notification permission is required. By enabling notifications, you won\'t miss important reminders.',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Reject', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Approve'),
              onPressed: () async {
                await requestPermissionForNotifications();
                await requestAlarmPermission();
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
    return result ?? false;
  }
}