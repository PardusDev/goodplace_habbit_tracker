import 'package:cloud_firestore/cloud_firestore.dart';

class DoneHabit {
  final String habitId;
  final DateTime doneAt;

  DoneHabit({required this.habitId, required this.doneAt});

  factory DoneHabit.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DoneHabit(
      habitId: data['habitId'],
      doneAt: (data['doneAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'habitId': habitId,
      'doneAt': Timestamp.fromDate(doneAt),
    };
  }

  factory DoneHabit.fromMap(Map<String, dynamic> data) {
    return DoneHabit(
      habitId: data['habitId'],
      doneAt: (data['doneAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'habitId': habitId,
      'doneAt': Timestamp.fromDate(doneAt),
    };
  }
}