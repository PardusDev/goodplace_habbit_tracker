import 'package:cloud_firestore/cloud_firestore.dart';

class DoneHabit {
  late String id;
  final String habitId;
  final DateTime doneAt;

  DoneHabit({required this.id, required this.habitId, required this.doneAt});

  factory DoneHabit.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DoneHabit(
      id: data['id'],
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
      id: data['id'],
      habitId: data['habitId'],
      doneAt: (data['doneAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'habitId': habitId,
      'doneAt': Timestamp.fromDate(doneAt),
    };
  }
}