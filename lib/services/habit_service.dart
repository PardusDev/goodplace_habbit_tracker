import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goodplace_habbit_tracker/core/exceptions/handle_firebase_exception.dart';
import 'package:goodplace_habbit_tracker/models/UserHabit.dart';

class HabitService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  HabitService({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
    _firestore = firestore ?? FirebaseFirestore.instance;

  //region Check habit and doneHabit collections
  Future<bool> checkIfDoneHabitExists(String userId, String habitId) async {
    try {
      final querySnapshot = await _firestore
          .collection("users").doc(userId)
          .collection("habits").doc(habitId)
          .collection("doneHabits")
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw e;
    } finally {
      return false;
    }
  }

  Future<bool> checkIfHabitExists(String userId) async {
    try {
      final habitsCollection = await _firestore
          .collection("users").doc(userId)
          .collection("habit")
          .limit(1)
          .get();
      if (habitsCollection.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw e;
    } finally {
      return false;
    }
  }
  //endregion

  //region Create a habit
  Future<void> addNewHabit(String uid, UserHabit userHabit) async {
    try {
      final habitRef = _firestore.collection("users").doc(uid).collection("habits").doc();
      await habitRef.set(userHabit.toDocument());
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw e;
    }
  }
}