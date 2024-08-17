import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:goodplace_habbit_tracker/utilities/get_extension_of_file.dart';
import 'package:uuid/uuid.dart';

import '../constants/string_constants.dart';
import '../core/exceptions/handle_firebase_exception.dart';
import '../models/ImageModel.dart';

class ImageService {
  final FirebaseFirestore _firestore;
  final _storageReference = FirebaseStorage.instance;

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

  Future<ImageModel> uploadImage(File selectedImage) async {
    try {
      // Get a unique id for the image
      final uniqueId = const Uuid().v4();
      final fileExtension = getExtensionOfFile(selectedImage.path);

      final fileName = '$uniqueId.$fileExtension';

      final storageReference = _storageReference.ref().child('userMotivationImages/$fileName');
      final storageUploadTask = storageReference.putFile(selectedImage);

      final snapshot = await storageUploadTask.whenComplete(() => null);
      final downloadUrl =  await storageReference.getDownloadURL();

      ImageModel imageModel = ImageModel(
        id: uniqueId,
        url: downloadUrl,
      );

      return imageModel;
    } catch (e) {
      throw "An error occured while uploading the image.";
    }
  }
}