import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/constants/icon_constants.dart';

SnackBar errorSnackBar (String text) {
  return SnackBar(
    content: Row(
      children: [
        const Icon(
          IconConstants.snackErrorIcon,
          color: ColorConstants.errorColor,
        ),
        const SizedBox(
          width: 6,
        ),
        Flexible(child: Text(text)),
      ],
    ),
  );
}

SnackBar warningSnackBar (String text) {
  return SnackBar(
    content: Row(
      children: [
        const Icon(
          IconConstants.snackWarningIcon,
          color: ColorConstants.warningSnackBarColor,
        ),
        const SizedBox(width: 20,),
        Flexible(child: Text(text)),
      ],
    ),
  );
}

SnackBar successSnackBar (String text) {
  return SnackBar(
    content: Row(
      children: [
        const Icon(
          IconConstants.snackSuccessIcon,
          color: ColorConstants.successSnackBarColor,
        ),
        const SizedBox(width: 20,),
        Flexible(child: Text(text)),
      ],
    ),
  );
}