import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CheckboxWithWidget extends StatefulWidget {
  final MainAxisAlignment mainAxisAlignment;
  final Widget child;
  final ValueChanged<bool> onChanged;
  final bool isChecked;
  const CheckboxWithWidget({super.key, this.mainAxisAlignment = MainAxisAlignment.spaceBetween, required this.child, required this.onChanged, required this.isChecked});

  @override
  State<CheckboxWithWidget> createState() => _CheckboxWithWidgetState();
}

class _CheckboxWithWidgetState extends State<CheckboxWithWidget> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  void _onChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        widget.child,
        Checkbox(
            value: widget.isChecked,
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
