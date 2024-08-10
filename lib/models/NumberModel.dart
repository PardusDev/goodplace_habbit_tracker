import 'package:cloud_firestore/cloud_firestore.dart';

class NumberModel {
  NumberModel({
    this.number,
  });

  final String? number;

  Map<String, dynamic> toJson() {
    return {
      'number': number,
    };
  }

  NumberModel fromJson(Map<String, dynamic> json) {
    return NumberModel(
      number: json['number'] as String?,
    );
  }

  NumberModel fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NumberModel (
      number: data['number'] as String?,
    );
  }
}