import 'package:cloud_firestore/cloud_firestore.dart';

import 'DoneHabit.dart';

class UserHabit {
  late String habitId;
  final String title;
  final String subject;
  final String imagePath;
  final DateTime createdAt;
  final List<DoneHabit> doneHabits;

  UserHabit({required this.habitId, required this.title, required this.subject, required this.imagePath, required this.createdAt, required this.doneHabits});

  factory UserHabit.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserHabit(
      habitId: doc.id,
      title: data["title"],
      subject: data["subject"],
      imagePath: data["imagePath"],
      createdAt: (data["createdAt"] as Timestamp).toDate(),
      doneHabits: (data["doneHabits"] as List?)
          ?.map((item) => DoneHabit.fromMap(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      'subject': subject,
      'imagePath': imagePath,
      'createdAt': DateTime.now(),
    };
  }

  void addDoneHabit(DoneHabit doneHabit) {
    doneHabits.add(doneHabit);
  }

  void removeDoneHabit(DoneHabit doneHabit) {
    doneHabits.remove(doneHabit);
  }

  void clearDoneHabits() {
    doneHabits.clear();
  }
}