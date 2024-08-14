import 'package:intl/intl.dart';

String generateIdFromDate(DateTime dateTime) {
  String formattedDate = DateFormat('yyyyMMdd').format(dateTime);
  return formattedDate;
}