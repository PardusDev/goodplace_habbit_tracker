import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';

import '../../constants/string_constants.dart';
import '../../init/navigation/navigation_service.dart';
import '../../managers/HabitManager.dart';
import '../../models/DoneHabit.dart';
import '../../models/UserHabit.dart';
import '../../utilities/generate_id_from_date.dart';
import '../../utilities/normalize_date.dart';
import '../../widgets/Snackbars.dart';
import '../../widgets/SuccessSplashBox.dart';
import '../ai_chat/ai_chat_page.dart';

class HabitDetailViewModel extends ChangeNotifier with BaseViewModel {
  UserHabit currentHabit;
  final HabitManager _habitManager = HabitManager();
  final _navigationService = NavigationService.instance;

  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<DoneHabit>> _events = {};

  DateTime get selectedDay => _selectedDay;
  Map<DateTime, List<DoneHabit>> get events => _events;
  List<UserHabit> get habits => _habitManager.habits;

  set selectedDay(DateTime value) {
    _selectedDay = value;
    notifyListeners();
  }

  String _habitTitle = "";
  get habitTitle => _habitTitle;

  String _habitDescription = "";
  get habitDescription => _habitDescription;

  HabitDetailViewModel({required this.currentHabit}) {
    fetchDoneHabitsForSpecificMonth(DateTime.now());
    _habitManager.addListener(_onHabitsUpdated);
    showHabitDetails();
  }

  void showHabitDetails() {
    _habitTitle = currentHabit.title;
    _habitDescription = currentHabit.subject;
    notifyListeners();
  }

  void _onHabitsUpdated() {
    notifyListeners();
  }

  // For the calendar
  void prepareEvents() {
    for (var doneHabit in currentHabit.doneHabits) {
      prepareAndAddEvent(doneHabit);
    }
  }

  void prepareAndAddEvent(DoneHabit doneHabit) {
    DateTime date = DateTime(doneHabit.doneAt.year, doneHabit.doneAt.month, doneHabit.doneAt.day);

    if (_events[date] != null) {
      _events[date]!.add(doneHabit);
    } else {
      _events[date] = [doneHabit];
    }
  }

  void removeEvent(DoneHabit doneHabit) {
    DateTime date = DateTime(doneHabit.doneAt.year, doneHabit.doneAt.month, doneHabit.doneAt.day);
    _events[date]!.remove(doneHabit);
    notifyListeners();
  }

  Future<void> fetchDoneHabitsForSpecificMonth(DateTime date) async {
    User? user = FirebaseAuth.instance.currentUser;
    // Before fetching the done habits, we need to reset the events
    resetEvents();
    await _habitManager.loadDoneHabitForSpecificMonth(user!.uid, currentHabit.habitId, date.year, date.month);
    prepareEvents();
    notifyListeners();
  }

  void toggleHabit(BuildContext buildContext, UserHabit habit, bool isCompleted) async {
    try {
      User firebaseUser = FirebaseAuth.instance.currentUser!;
      UserHabit nonUpdatedHabit = habit.copyWith();
      DoneHabit doneHabit = DoneHabit(
          id: generateIdFromDate(selectedDay),
          habitId: habit.habitId,
          doneAt: selectedDay
      );

      // Block if the selected date is past
      DateTime normalizedToday = normalizeDate(DateTime.now());
      DateTime normalizedSelectedDate = normalizeDate(selectedDay);
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
        await _habitManager.addDoneHabit(firebaseUser, habit, doneHabit);

        // Add the event to the calendar
        prepareAndAddEvent(doneHabit);

        // Show success splash box
        showDialog(
            context: buildContext,
            builder: (BuildContext context) {
              return SuccessSplashBox(
                onPressed: () {
                  // Show snackbar for undo
                  ScaffoldMessenger.of(buildContext).showSnackBar(
                    SnackBar(
                      content: const Text(StringConstants.successUndoText),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () async {
                          // Undo the action here
                          await _habitManager.undoDoneHabit(firebaseUser, habit, doneHabit, nonUpdatedHabit);

                          // Remove the event from the calendar
                          removeEvent(doneHabit);

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
      throw e;
    }
  }

  void getUpdatedHabit() {
    currentHabit = habits.firstWhere((element) => element.habitId == currentHabit.habitId);
  }

  bool checkHabitIsCompletedForSelectedDate(UserHabit habit) {
    return _habitManager.checkHabitIsCompletedForSelectedDate(habit, _selectedDay);
  }

  void resetEvents() {
    _events = {};
    notifyListeners();
  }

  void navigateToEditHabit() {
    _navigationService.navigateToPage("/editHabit", currentHabit).then((_) {
        getUpdatedHabit();
        notifyListeners();
      }
    );
  }

  void startAiChat(BuildContext buildContext) {
    showModalBottomSheet(
        context: buildContext,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AiChatPage(userHabit: currentHabit);
        }
    ).then((value) => notifyListeners());
  }
}