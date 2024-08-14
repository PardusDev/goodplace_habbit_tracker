import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/init/navigation/navigation_service.dart';
import 'package:goodplace_habbit_tracker/locator.dart';
import 'package:goodplace_habbit_tracker/pages/create_habit/create_habit_modal.dart';
import 'package:goodplace_habbit_tracker/repository/repository.dart';
import 'package:provider/provider.dart';

import '../../managers/AppUserManager.dart';
import '../../services/auth_service.dart';
import '../../widgets/Snackbars.dart';

enum ViewState { geliyor, geldi, hata }

class HomePageViewModel with ChangeNotifier {
  final Repository _repository = locator<Repository>();
  ViewState _state = ViewState.geliyor;
  ViewState get state => _state;
  String motivasyon="";
  String greeting="";
  final NavigationService _navigationService = NavigationService.instance;
  final AuthService _authService = AuthService();
  Timer? _timer; // Timer to update greeting message periodically

  HomePageViewModel() {
    getGreetingMessage();
    startGreetingUpdateTimer(); // Start the timer when the ViewModel is created
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the ViewModel is disposed
    super.dispose();
  }


  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  getMotivasyon()async{
    try {
      motivasyon = await _repository.getMotivasyon();
    } catch (e) {
      // Maybe we can get motivation from local storage
      motivasyon = e.toString();
    } finally {
      notifyListeners();
    }
  }

  /// Get user details from Firebase and set it to AppUserManager
  void getUserInformation(BuildContext buildContext) {
    try {
      User? firebaseUser = _authService.getCurrentUser();
      _authService.getUserByUID(firebaseUser!.uid).then((value) {
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
    );
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
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      getGreetingMessage();
    });
  }
}