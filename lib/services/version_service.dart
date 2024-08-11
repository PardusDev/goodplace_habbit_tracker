import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../enums/platform_enum.dart';
import '../models/NumberModel.dart';

class VersionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getVersionNumber() async {
    // If the platform is web, return null.
    if (kIsWeb) return null;

    final response = await _firestore.collection("version")
        .withConverter<NumberModel>(
        fromFirestore: (snapshot, options) => NumberModel().fromDocument(snapshot),
        toFirestore: (value, options) => value.toJson()
    )
        .doc(PlatformEnum.versionName)
        .get();

    return response.data()?.number;
  }
}