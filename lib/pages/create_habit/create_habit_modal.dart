import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/create_habit/create_habit_modal_view_model.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../widgets/CollapsableBottomSheetMultipleWidget.dart';
import '../../widgets/CustomShimmer.dart';
import '../../widgets/SelectableImageCard.dart';

class CreateHabitModal extends StatelessWidget {
  const CreateHabitModal({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateHabitModalViewModel>(
      create: (context) => CreateHabitModalViewModel(),
      child: Consumer<CreateHabitModalViewModel>(
        builder: (context, viewModel, child) {
          return CollapsableBottomSheetMultipleWidget(
            title: StringConstants.createHabitScreenTitle,
            buttonText: StringConstants.createHabitScreenCreateButton,
            onPressed: viewModel.createHabit,
            children: [
              InputSection(
                title: "Habit Name",
                description: "Enter the name of the habit you want to create.",
                hintText: StringConstants.createHabitScreenNameHint,
                controller: viewModel.titleController,
                onChanged: viewModel.onTitleChanged,
              ),
              const SizedBox(height: 16.0),
              InputSection(
                title: "Habit Subject - Optional",
                description: "Describe the subject of your habit.",
                hintText: StringConstants.createHabitScreenSubjectHint,
                controller: viewModel.subjectController,
              ),
              const SizedBox(height: 24.0),
              ImageSelectionSection(
                onPressed: () async {
                  viewModel.uploadImage();
                },
              ),
              const SizedBox(height: 16.0),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewModel.images.length,
                itemBuilder: (context, index) {
                  if (viewModel.imagesIsLoading) {
                    return const CustomShimmer(
                      height: 100.0,
                      width: 100.0,
                    );
                  }

                  return SelectableImageCard(
                    imageUrl: viewModel.images[index].url,
                    isSelected: viewModel.selectedImageIndex == index,
                    onTap: () {
                      viewModel.selectedImageIndex = index;
                    },
                  );
                },
              ),
              const SizedBox(height: 24.0,),
              Consumer<CreateHabitModalViewModel>(
                  builder: (context, viewModel, child) {
                    return Visibility(
                      visible: viewModel.errorText.isNotEmpty,
                      child: Text(
                        viewModel.errorText,
                        style: context.general.textTheme.titleSmall!.copyWith(
                          color: ColorConstants.errorColor,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    );
                  }
              )
            ],
          );
        },
      ),
    );
  }
}

class InputSection extends StatelessWidget {
  final String title;
  final String description;
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const InputSection({
    required this.title,
    required this.description,
    required this.hintText,
    required this.controller,
    super.key, this.onChanged,
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
            onChanged: onChanged,
            controller: controller,
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
  final VoidCallback onPressed;
  const ImageSelectionSection({super.key, required this.onPressed});

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
              onPressed();
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
