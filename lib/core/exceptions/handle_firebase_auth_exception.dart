import 'package:firebase_auth/firebase_auth.dart';

import '../../constants/string_constants.dart';

T handleFirebaseAuthException<T>(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-email':
      throw(StringConstants.invalidEmail);
    case 'wrong-password':
      throw StringConstants.wrongPassword;
    case 'too-many-requests':
      throw(StringConstants.tooManyRequests);
    case 'account-exists-with-different-credential':
      throw StringConstants.accountExists;
    case 'invalid-credential':
      throw StringConstants.invalidCredential;
    case 'operation-not-allowed':
      throw StringConstants.operationNotAllowed;
    case 'user-disabled':
      throw StringConstants.userDisabled;
    case 'user-not-found':
      throw StringConstants.userNotFound;
    case 'invalid-verification-code':
      throw StringConstants.invalidVerificationCode;
    case 'invalid-verification-id':
      throw StringConstants.invalidVerificationId;
    default:
      throw(StringConstants.anErrorOccured);
  }
}