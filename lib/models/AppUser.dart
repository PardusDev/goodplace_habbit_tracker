import 'package:cloud_firestore/cloud_firestore.dart';

// This class is used to store the user information
// It is used to store the user id and email
// But it can be extended to store more information
class AppUser {
  final String uid;
  final String name;
  final String email;

  AppUser({required this.name, required this.uid, required this.email});

  factory AppUser.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUser (
        uid: data["uid"],
        name: data["name"],
        email: data["email"],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> data) {
    return AppUser(
      uid: data["uid"],
      name: data["name"],
      email: data["email"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}