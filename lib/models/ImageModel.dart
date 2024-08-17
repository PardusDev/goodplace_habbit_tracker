import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
  final String id;
  final String url;

  ImageModel({required this.id, required this.url});

  factory ImageModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ImageModel(
      id: doc.id,
      url: data['url'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'url': url,
    };
  }
}