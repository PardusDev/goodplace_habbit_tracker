import 'package:firebase_core/firebase_core.dart';
import 'package:goodplace_habbit_tracker/constants/string_constants.dart';

T handleFirebaseException<T>(FirebaseException e) {
  switch (e.code) {
    case 'cancelled':
      throw StringConstants.operationCancelled;
    case 'unknown':
      throw StringConstants.unknownError;
    case 'invalid-argument':
      throw StringConstants.invalidArgument;
    case 'deadline-exceeded':
      throw StringConstants.deadlineExceeded;
    case 'not-found':
      throw StringConstants.documentNotFound;
    case 'already-exists':
      throw StringConstants.documentAlreadyExists;
    case 'permission-denied':
      throw StringConstants.permissionDenied;
    case 'resource-exhausted':
      throw StringConstants.resourceExhausted;
    case 'failed-precondition':
      throw StringConstants.failedPrecondition;
    case 'aborted':
      throw StringConstants.operationAborted;
    case 'out-of-range':
      throw StringConstants.outOfRange;
    case 'unimplemented':
      throw StringConstants.operationNotImplemented;
    case 'internal':
      throw StringConstants.internalError;
    case 'unavailable':
      throw StringConstants.serviceUnavailable;
    case 'data-loss':
      throw StringConstants.dataLoss;
    case 'unauthenticated':
      throw StringConstants.unauthenticated;
    default:
      throw StringConstants.anErrorOccured;
  }
}