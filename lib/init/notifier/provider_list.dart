import 'package:goodplace_habbit_tracker/managers/AppUserManager.dart';
import 'package:goodplace_habbit_tracker/managers/HabitManager.dart';
import 'package:goodplace_habbit_tracker/pages/habit_detail/habit_detail_view_model.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page_view_model.dart';
import 'package:goodplace_habbit_tracker/pages/manage_my_habits/manage_my_habits_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../pages/create_habit/create_habit_modal_view_model.dart';
import '../../pages/splash/splash_page_view_model.dart';

class ProviderList {
  // Can't create an instance of this class. Use it directly.
  static final ProviderList _instance = ProviderList._();
  static ProviderList get instance => _instance;

  ProviderList._();

  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(create: (_) => AppUserManager()),
    ChangeNotifierProvider(create: (_) => HabitManager()),
    ChangeNotifierProvider(create: (_) => SplashPageViewModel(), lazy: true),
    ChangeNotifierProvider(create: (_) => HomePageViewModel()),
    ChangeNotifierProvider(create: (_) => CreateHabitModalViewModel()),
    ChangeNotifierProvider(create: (_) => HabitDetailViewModel()),
    ChangeNotifierProvider(create: (_) => ManageMyHabitsViewModel()),
  ];
}