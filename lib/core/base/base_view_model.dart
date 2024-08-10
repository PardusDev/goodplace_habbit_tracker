import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/init/navigation/navigation_service.dart';

mixin BaseViewModel {
  late BuildContext buildContext;

  NavigationService navigationService = NavigationService.instance;

  void setContext(BuildContext context) {
    buildContext = context;
  }
}