import 'package:intl/intl.dart';

String dateFormatterToShow(DateTime date) {
  String formattedDate = DateFormat('d\'th\' MMMM yyyy').format(date);

  String daySuffix = getDayOfMonthSuffix(date.day);
  formattedDate = formattedDate.replaceFirst('th', daySuffix);

  return formattedDate;
}

String getDayOfMonthSuffix(int day) {
  if (!(day >= 1 && day <= 31)) {
    throw Exception('Invalid day of month');
  }
  if (day >= 11 && day <= 13) {
    return 'th';
  }
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}