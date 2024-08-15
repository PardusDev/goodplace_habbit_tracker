import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/string_constants.dart';
import '../core/exceptions/handle_firebase_exception.dart';
import '../models/ImageModel.dart';

class ImageService {
  final FirebaseFirestore _firestore;

  ImageService({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<ImageModel>?> fetchImages() async {
    try {
      final querySnapshot = await _firestore
          .collection('exampleMotivationImages')
          .get();
      final exampleImages = querySnapshot.docs.map((doc) => ImageModel.fromDocument(doc)).toList();
      return exampleImages;
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw StringConstants.anErrorOccured;
    }
    return null;
  }
}