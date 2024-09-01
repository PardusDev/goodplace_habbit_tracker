import 'package:cloud_firestore/cloud_firestore.dart';

import 'DoneHabit.dart';

class UserHabit {
  late String habitId;
  final String title;
  final String subject;
  final String imagePath;
  final DateTime createdAt;
  List<DoneHabit> doneHabits;
  int maxStreak;
  DateTime? currentStreakLastDate;
  int currentStreak;

  UserHabit({required this.habitId, required this.title, required this.subject, required this.imagePath, required this.createdAt, required this.doneHabits, required this.maxStreak, required this.currentStreakLastDate, required this.currentStreak});

  factory UserHabit.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserHabit(
      habitId: doc.id,
      title: data["title"],
      subject: data["subject"],
      imagePath: data["imagePath"],
      createdAt: (data["createdAt"] as Timestamp).toDate(),
      doneHabits: [],
      maxStreak: data["maxStreak"],
      currentStreakLastDate: data["currentStreakLastDate"] != null ? (data["currentStreakLastDate"] as Timestamp).toDate() : null,
      currentStreak: data["currentStreak"],
    );
  }

  UserHabit copyWith({
    String? habitId,
    String? title,
    String? subject,
    String? imagePath,
    DateTime? createdAt,
    List<DoneHabit>? doneHabits,
    int? maxStreak,
    DateTime? currentStreakLastDate,
    int? currentStreak,
  }) {
    return UserHabit(
      habitId: habitId ?? this.habitId,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      doneHabits: doneHabits ?? this.doneHabits,
      maxStreak: maxStreak ?? this.maxStreak,
      currentStreakLastDate: currentStreakLastDate ?? this.currentStreakLastDate,
      currentStreak: currentStreak ?? this.currentStreak,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      'subject': subject,
      'imagePath': imagePath,
      'createdAt': DateTime.now(),
      'maxStreak': maxStreak,
      'currentStreakLastDate': currentStreakLastDate,
      'currentStreak': currentStreak,
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