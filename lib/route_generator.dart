import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page.dart';

class RouteGenerator {
  static Route<dynamic>? _gidilecekrota(
      Widget gidilecekWidget, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
          settings: settings, builder: (context) => gidilecekWidget);
    } else {
      return MaterialPageRoute(
          settings: settings, builder: (context) => gidilecekWidget);
    }
  }

  static Route<dynamic>? rotaOlustur(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _gidilecekrota(const HomePage(), settings);
      case '/homepage':
        return _gidilecekrota(const HomePage(), settings);
      default:
        return _gidilecekrota(const HomePage(), settings);
    }
  }
}