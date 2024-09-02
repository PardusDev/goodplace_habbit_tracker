import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../firebase_options.dart';
import '../../locator.dart';
import '../../services/firebase_messaging_service.dart';

import 'package:timezone/data/latest.dart' as tz;

@immutable
class ApplicationStart {
  // Can't create an instance of this class
  const ApplicationStart._();

  static Future<void> init() async {
    tz.initializeTimeZones();

    WidgetsFlutterBinding.ensureInitialized();
    // Set portrait orientation
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    setupLocator();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}