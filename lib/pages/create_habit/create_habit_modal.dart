import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/create_habit/create_habit_modal_view_model.dart';
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
            InputSection(
              title: "Habit Name",
              description: "Enter the name of the habit you want to create.",
              hintText: StringConstants.createHabitScreenNameHint,
            ),
            SizedBox(height: 16.0),
            InputSection(
              title: "Habit Subject",
              description: "Describe the subject of your habit.",
              hintText: StringConstants.createHabitScreenSubjectHint,
            ),
            SizedBox(height: 24.0),
            ImageSelectionSection(),
          ],
        );
      },
    );
  }
}

class InputSection extends StatelessWidget {
  final String title;
  final String description;
  final String hintText;

  const InputSection({
    required this.title,
    required this.description,
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            description,
            style: const TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
          const SizedBox(height: 8.0),
          TextField(
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageSelectionSection extends StatelessWidget {
  const ImageSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add Image",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            "Select an image to represent this habit.",
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: () {
              // Resim seçme fonksiyonunu tetikle
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.grey),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Text(
                    StringConstants.createHabitScreenAddImageLabel,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
