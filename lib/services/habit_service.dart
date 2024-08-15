import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goodplace_habbit_tracker/core/exceptions/handle_firebase_exception.dart';
import 'package:goodplace_habbit_tracker/models/DoneHabit.dart';
import 'package:goodplace_habbit_tracker/models/UserHabit.dart';

import '../utilities/generate_id_from_date.dart';

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
    }
    return false;
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

  Future<bool> checkIfDoneHabitExistsForSpecificDay (User user, String habitId, DateTime date) async {
    try {
      final convertDateToId = generateIdFromDate(date);
      final querySnapshot = await _firestore
          .collection("users").doc(user.uid)
          .collection("habits").doc(habitId)
          .collection("doneHabits").doc(convertDateToId)
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

  Future<bool?> checkIfDoneHabitExistsSpecificId (User user, String habitId, String doneHabitId) async {
    try {
      final querySnapshot = await _firestore
          .collection("users").doc(user.uid)
          .collection("habits").doc(habitId)
          .collection("doneHabits").doc(doneHabitId)
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
    }
    return false;
  }
  //endregion

  //region Create a habit
  Future<String?> addNewHabit(User user, UserHabit userHabit) async {
    try {
      final habitRef = _firestore.collection("users").doc(user.uid).collection("habits").doc();
      await habitRef.set(userHabit.toDocument());
      // Return the habitId to be used in the doneHabit collection
      return habitRef.id;
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw e;
    }
    return null;
  }
  //endregion

  //region Add done habit
  Future<String?> addDoneHabit(User user, DoneHabit doneHabit) async {
    try {
      final exists = await checkIfDoneHabitExistsSpecificId(user, doneHabit.habitId, doneHabit.id);
      if (exists == true) {
        // TODO: Implement you already did this habit. Do you want to cancel it?
        throw Exception("Done habit already exists");
      }

      final doneHabitRef = _firestore
          .collection("users").doc(user.uid)
          .collection("habits").doc(doneHabit.habitId)
          .collection("doneHabits").doc(doneHabit.id);
      await doneHabitRef.set(doneHabit.toDocument());
      return doneHabitRef.id;
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw e;
    }
    return null;
  }
  //endregion

  //region Get Done Habits According to Day
  Future<DoneHabit?> getDoneHabitForSpecificDay(String uid, String habitId, DateTime date) async {
    try {
      final convertDateToId = generateIdFromDate(date);
      final querySnapshot = await _firestore
          .collection("users").doc(uid)
          .collection("habits").doc(habitId)
          .collection("doneHabits").doc(convertDateToId)
          .get();
      if (querySnapshot.exists) {
        return DoneHabit.fromDocument(querySnapshot);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw e;
    }
    return null;
  }
  //endregion

  // region Get Done Habits According to Month
  Future<List<DoneHabit>> getDoneHabitsForSpecificMonth(String uid, String habitId, int year, int month) async {
    try {
      final startDateId = generateIdFromDate(DateTime(year, month, 1));
      // With this method, we can get the last day of the month
      final endDateId = generateIdFromDate(DateTime(year, month + 1, 1).subtract(const Duration(days: 1)));

      final querySnapshot = await _firestore
          .collection("users").doc(uid)
          .collection("habits").doc(habitId)
          .collection("doneHabits")
          .where(FieldPath.documentId, isGreaterThanOrEqualTo: startDateId)
          .where(FieldPath.documentId, isLessThanOrEqualTo: endDateId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) => DoneHabit.fromDocument(doc)).toList();
      } else {
        return [];
      }
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw e;
    }
    return [];
  }
  // endregion

  // region Delete Done Habit
  Future<bool> deleteDoneHabit(User user, DoneHabit doneHabit) async {
    try {
      final exists = await checkIfDoneHabitExists(user, doneHabit);
      if (exists == false) {
        throw Exception("Done habit does not exist");
      }
      await _firestore
          .collection("users").doc(user.uid)
          .collection("habits").doc(doneHabit.habitId)
          .collection("doneHabits").doc(doneHabit.id)
          .delete();
      return true;
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw e;
    }
    return false;
  }
  // endregion

  //region Get user habits
  Future<List<UserHabit>> getUserHabits(String uid) async {
    try {
      final querySnapshot = await _firestore.collection("users").doc(uid).collection("habits").get();
      return querySnapshot.docs.map((doc) => UserHabit.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw e;
    }
    return [];
  }
  //endregion

  //region Update habit
  Future<bool> updateHabit(User user, UserHabit userHabit) async {
    try {
      /*
      TODO: This method is not working properly. Fix it.
      final exists = await checkIfHabitExists(user, userHabit);
      if (exists == false) {
        throw Exception("Habit does not exist");
      }
      */
      await _firestore
          .collection("users").doc(user.uid)
          .collection("habits").doc(userHabit.habitId)
          .update(userHabit.toDocument());
      return true;
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw e;
    }
    return false;
  }
  //endregion
}