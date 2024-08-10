import 'package:flutter/material.dart';

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
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
