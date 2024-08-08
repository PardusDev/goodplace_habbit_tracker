import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/init/navigation/INavigationService.dart';

class NavigationService implements INavigationService {
  static final NavigationService _instance = NavigationService._();
  static NavigationService get instance => _instance;

  NavigationService._();

  // This key for all navigation operations
  // With that we can manage all navigation operations
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final removeAllOldRoutes = (Route<dynamic> route) => false;

  @override
  Future<void> navigateToPage(String path, Object? object) async {
    await navigatorKey.currentState!.pushNamed(path, arguments: object);
  }

  @override
  Future<void> navigateToPageClear(String path, Object? object) async {
    await navigatorKey.currentState!.pushNamedAndRemoveUntil(path, removeAllOldRoutes, arguments: object);
  }
}