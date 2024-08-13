import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goodplace_habbit_tracker/core/exceptions/handle_firebase_exception.dart';
import 'package:goodplace_habbit_tracker/models/DoneHabit.dart';
import 'package:goodplace_habbit_tracker/models/UserHabit.dart';

class HabitService {
  final FirebaseFirestore _firestore;

  HabitService({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
  : _firestore = firestore ?? FirebaseFirestore.instance;

  //region Check habit and doneHabit collections
  Future<bool> checkIfDoneHabitExists(User user, DoneHabit doneHabit) async {
    try {
      final querySnapshot = await _firestore
          .collection("users").doc(user.uid)
          .collection("habits").doc(doneHabit.habitId)
          .collection("doneHabits").doc(doneHabit.id)
          .get();
      if (querySnapshot.exists) {
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

  Future<bool> checkIfHabitExists(User user, UserHabit userHabit) async {
    try {
      final habitsCollection = await _firestore
          .collection("users").doc(user.uid)
          .collection("habit").doc(userHabit.habitId)
          .get();
      if (habitsCollection.exists) {
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
  Future<void> addNewHabit(User user, UserHabit userHabit) async {
    try {
      final habitRef = _firestore.collection("users").doc(user.uid).collection("habits").doc();
      await habitRef.set(userHabit.toDocument());
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw e;
    }
  }
  //endregion

  //region Get user habits
  Future<List<UserHabit>> getUserHabits(User user) async {
    try {
      final querySnapshot = await _firestore.collection("users").doc(user.uid).collection("habits").get();
      return querySnapshot.docs.map((doc) => UserHabit.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw e;
    }
    return [];
  }
  //endregion
}