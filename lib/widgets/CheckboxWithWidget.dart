import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CheckboxWithWidget extends StatefulWidget {
  final MainAxisAlignment mainAxisAlignment;
  final Widget child;
  final ValueChanged<bool> onChanged;
  const CheckboxWithWidget({super.key, this.mainAxisAlignment = MainAxisAlignment.spaceBetween, required this.child, required this.onChanged});

  @override
  State<CheckboxWithWidget> createState() => _CheckboxWithWidgetState();
}

class _CheckboxWithWidgetState extends State<CheckboxWithWidget> {
  bool? isChecked = false;

  void _onChanged(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });

    widget.onChanged(isChecked!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        widget.child,
        Checkbox(
            value: isChecked,
            onChanged: _onChanged,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: WidgetStateBorderSide.resolveWith(
                  (states) => const BorderSide(
                color: ColorConstants.checkboxBorderColor,
                width: 2,
              ),
            ),
            checkColor: ColorConstants.checkboxCheckedColor,
            fillColor: WidgetStateProperty.all(ColorConstants.checkboxBackgroundColor),
            visualDensity: VisualDensity.compact,
        )
      ],
    );
  }
}
