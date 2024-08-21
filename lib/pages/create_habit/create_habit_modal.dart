import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/create_habit/create_habit_modal_view_model.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../widgets/CollapsableBottomSheetMultipleWidget.dart';
import '../../widgets/CustomShimmer.dart';
import '../../widgets/SelectableImageCard.dart';
import 'package:shimmer/shimmer.dart';

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
                viewModel: viewModel,
              ),
              const SizedBox(height: 16.0),
              InputSection(
                title: "Habit Subject - Optional",
                description: "Describe the subject of your habit.",
                hintText: StringConstants.createHabitScreenSubjectHint,
                controller: viewModel.subjectController,
                viewModel: viewModel,
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
  final CreateHabitModalViewModel viewModel;
  final int maxChars = 25;

  const InputSection({
    required this.title,
    required this.description,
    required this.hintText,
    required this.controller,
    required this.viewModel,
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                ],
              ),
              const Expanded(child: SizedBox()),
              if (title == "Habit Subject - Optional") ...[
                GestureDetector(
                  onTap: () {
                    viewModel.autoFillDescription();
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange),
                      SizedBox(width: 5),
                      Text(
                        "Auto-fill",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8.0),
          if (title == "Habit Subject - Optional" && viewModel.descLoading)
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: TextField(
                enabled: false,
                controller: controller,
                maxLines: 5,
                minLines: 5,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            )
          else
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  onChanged: (value) {
                    if (title == "Habit Name") {
                      if (value.length <= maxChars) {
                        controller.text = value;
                        controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: value.length),
                        );
                      } else {
                        controller.text = value.substring(0, maxChars);
                        controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: maxChars),
                        );
                      }
                    }
                    if (onChanged != null) onChanged!(controller.text);
                  },
                  controller: controller,
                  maxLines: title == "Habit Subject - Optional" ? 5 : 1,
                  minLines: title == "Habit Subject - Optional" ? 5 : 1,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                  ),
                ),
                if (title == "Habit Name" && controller.text.length >= 20)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      '${controller.text.length}/$maxChars',
                      style: TextStyle(
                        color: controller.text.length == maxChars
                            ? Colors.red
                            : Colors.orange,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
              ],
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
