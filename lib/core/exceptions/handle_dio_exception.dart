import 'package:dio/dio.dart';

import '../../constants/string_constants.dart';

T handleDioException<T>(DioException e) {
  switch (e.type) {
    case DioExceptionType.cancel:
      throw StringConstants.requestCancelled ;
    case DioExceptionType.connectionTimeout:
      throw StringConstants.connectionTimeout;
    case DioExceptionType.sendTimeout:
      throw StringConstants.sendTimeout;
    case DioExceptionType.connectionError:
      throw StringConstants.connectionError;
    case DioExceptionType.receiveTimeout:
      throw StringConstants.receiveTimeout;
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw StringConstants.badRequest;
        case 401:
          throw StringConstants.unauthorized;
        case 403:
          throw StringConstants.forbidden;
        case 404:
          throw StringConstants.dioNotFound;
        case 500:
          throw StringConstants.internalServerError;
        default:
          throw StringConstants.unknownError;
      }
    case DioExceptionType.badCertificate:
      throw StringConstants.badCertificate;
    case DioExceptionType.unknown:
      throw StringConstants.anErrorOccured;
    default:
      throw StringConstants.anErrorOccured;
  }
}