import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goodplace_habbit_tracker/core/exceptions/handle_firebase_auth_exception.dart';
import 'package:goodplace_habbit_tracker/core/exceptions/handle_firebase_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/string_constants.dart';
import '../models/AppUser.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthService({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore, GoogleSignIn? googleSignIn})
  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
    _firestore = firestore ?? FirebaseFirestore.instance,
    _googleSignIn = googleSignIn ?? GoogleSignIn();

  User? getCurrentUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e);
    } catch (e) {
      throw StringConstants.anErrorOccured;
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e);
    } catch (e) {
      throw StringConstants.anErrorOccured;
    }
    return null;
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // User has stopped login
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

      // Store the user information in the 'users' collection
      if (userCredential.user != null) {
        // Check if the user is new
        if (userCredential.additionalUserInfo!.isNewUser) {
          AppUser newUser = AppUser(
            uid: userCredential.user!.uid,
            email: userCredential.user!.email!,
            name: userCredential.user!.displayName ?? '',
          );
          registerUserToDocuments(newUser);
        }
      }

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e);
    } catch (e) {
      throw StringConstants.anErrorOccured;
    }
    return null;
  }



  Future<User?> registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        AppUser newUser = AppUser(
          uid: userCredential.user!.uid,
          email: email,
          name: name,
        );
        registerUserToDocuments(newUser);
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e);
    } catch (e) {
      throw StringConstants.anErrorOccured;
    }
    return null;
  }

  Future<void> registerUserToDocuments(AppUser newUser) async {
    try {
      await _firestore.collection('users').doc(newUser.uid).set(newUser.toDocument());
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw StringConstants.anErrorOccured;
    }
  }

  /// Don't forget: This method getting the user from the Firestore
  Future<AppUser?> getUserByUID(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        final result = AppUser.fromDocument(doc);
        return result;
      }
      return null;
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw StringConstants.anErrorOccured;
    }
    // When the an error occured, return null.
    return null;
  }

  Future<void> signOut() async {
    try {
      // To sign out from both Firebase and Google
      // Used Future.wait to wait for both operations to complete
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut()
      ]);
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e);
    } catch (e) {
      throw StringConstants.anErrorOccured;
    }
  }

  // Delete user account
  // With that, delete the user from the 'users' collection
  Future<void> deleteAccountPermanently() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).delete();
        await user.delete();
      }
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw StringConstants.anErrorOccured;
    }
  }
}