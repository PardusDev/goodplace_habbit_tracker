import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/string_constants.dart';

class ConfirmAlertDialog extends StatelessWidget {
  final String title;
  final String body;
  const ConfirmAlertDialog({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text(StringConstants.alertDialogCancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text(StringConstants.alertDialogConfirm),
        ),
      ],
    );
  }
}
