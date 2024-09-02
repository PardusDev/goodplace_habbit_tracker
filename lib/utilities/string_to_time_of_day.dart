import 'package:flutter/material.dart';

TimeOfDay stringToTimeOfDay(String formattedTime) {
  final parts = formattedTime.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}