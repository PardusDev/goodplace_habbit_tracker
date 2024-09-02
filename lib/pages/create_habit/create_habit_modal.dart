import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/create_habit/create_habit_modal_view_model.dart';
import 'package:goodplace_habbit_tracker/widgets/CheckboxWithWidget.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../widgets/CollapsableBottomSheetMultipleWidget.dart';
import '../../widgets/CustomShimmer.dart';
import '../../widgets/InputSection.dart';
import '../../widgets/SelectableImageCard.dart';
import '../../widgets/TappableWidget.dart';

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
                onAutofillTap: viewModel.autoFillDescription,
                descLoading: viewModel.descLoading,
              ),
              const SizedBox(height: 12.0),
              // region Remind Me
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxWithWidget(
                      onChanged: viewModel.toggleRemindMeCheckbox,
                      child: const Text(
                        "Remind Me Every Day - Optional",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      )
                  ),
                  const Text(
                    "Select a time for the reminder.",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 10.0),
                  TappableWidget(
                      onPressed: () {
                        viewModel.selectTime(context);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.access_alarm, color: Colors.blueAccent),
                          context.sized.emptySizedWidthBoxLow3x,
                          Text(
                              '${viewModel.selectedTime?.hour}:${viewModel.selectedTime?.minute}',
                              style: context.general.textTheme.headlineMedium!.copyWith(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold
                              )
                          )
                        ],
                      )
                  ),
                ],
              ),
              // endregion
              const SizedBox(height: 20.0),
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
