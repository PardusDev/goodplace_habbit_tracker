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

  Future<User?> getCurrentUser() async {
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
          registerUserToDocuments(userCredential.user!.uid, userCredential.user!.email!);
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



  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        registerUserToDocuments(userCredential.user!.uid, email);
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e);
    } catch (e) {
      throw StringConstants.anErrorOccured;
    }
    return null;
  }

  Future<void> registerUserToDocuments(String uid, String email) async {
    AppUser newUser = AppUser(
      uid: uid,
      email: email,
    );
    try {
      await _firestore.collection('users').doc(newUser.uid).set(newUser.toDocument());
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } catch (e) {
      throw StringConstants.anErrorOccured;
    }
  }

  // Get the uid of the current and search it in the 'users' collection
  Future<AppUser?> getUserByUID(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return AppUser.fromDocument(doc);
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
}