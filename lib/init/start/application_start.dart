import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../firebase_options.dart';
import '../../locator.dart';

@immutable
class ApplicationStart {
  // Can't create an instance of this class
  const ApplicationStart._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Set portrait orientation
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    setupLocator();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}