import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/utilities/string_to_time_of_day.dart';

import '../utilities/time_of_day_to_string.dart';
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
  TimeOfDay? reminderTime;

  UserHabit({required this.habitId, required this.title, required this.subject, required this.imagePath, required this.createdAt, required this.doneHabits, required this.maxStreak, required this.currentStreakLastDate, required this.currentStreak, required this.reminderTime});

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
      reminderTime: data["reminderTime"] != null ? stringToTimeOfDay(data["reminderTime"]) : null,
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
    String? reminderTime,
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
      reminderTime: reminderTime != null ? stringToTimeOfDay(reminderTime) : this.reminderTime,
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
      'reminderTime': reminderTime != null ? timeOfDayToString(reminderTime!) : null,
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