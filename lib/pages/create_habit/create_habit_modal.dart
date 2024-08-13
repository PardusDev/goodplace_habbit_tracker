import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/create_habit/create_habit_modal_view_model.dart';
import 'package:goodplace_habbit_tracker/widgets/OneLineInputField.dart';
import 'package:provider/provider.dart';

import '../../constants/string_constants.dart';
import '../../widgets/CollapsableBottomSheetMultipleWidget.dart';

class CreateHabitModal extends StatelessWidget {
  const CreateHabitModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateHabitModalViewModel>(
      builder: (context, viewModel, child) {
        return CollapsableBottomSheetMultipleWidget(
            title: StringConstants.createHabitScreenTitle,
            buttonText: StringConstants.createHabitScreenCreateButton,
            onPressed: viewModel.createHabit,
            children: const [
              OneLineInputField(hintText: StringConstants.createHabitScreenNameHint),
              OneLineInputField(hintText: StringConstants.createHabitScreenSubjectHint),
              Text(StringConstants.createHabitScreenAddImageLabel),
            ],
        );
      }
    );
  }
}
