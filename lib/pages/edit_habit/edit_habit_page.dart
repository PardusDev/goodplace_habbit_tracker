import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/widgets/BackButtonWithBorder.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/string_constants.dart';
import '../../models/UserHabit.dart';
import '../../widgets/CustomShimmer.dart';
import '../../widgets/InputSection.dart';
import '../../widgets/SelectableImageCard.dart';
import '../../widgets/StadiumSideBlueButton.dart';
import '../create_habit/create_habit_modal.dart';
import 'edit_habit_page_view_model.dart';

class EditHabitPage extends StatelessWidget {
  const EditHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userHabit = ModalRoute.of(context)!.settings.arguments as UserHabit;

    return ChangeNotifierProvider(
      create: (context) => EditHabitPageViewModel(userHabit),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstants.backgroundColor,
        body: Padding(
          padding: context.padding.normal,
          child: Column(
            children: [
              const Spacer(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Consumer<EditHabitPageViewModel>(
                          builder: (context, viewModel, child) {
                            return BackButtonWithBorder(
                              onPressed: () {
                                viewModel.navigationService.navigateToBack();
                              }
                            );
                          }
                        ),

                        const SizedBox(width: 8.0),

                        Text(
                          StringConstants.editHabitPageTitle,
                          style: context.general.textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.collapsableBottomSheetTitleColor),
                        ),
                      ],
                    ),

                    Consumer<EditHabitPageViewModel>(
                        builder: (context, viewModel, child) {
                      return IconButton(
                        onPressed: () {
                          viewModel.deleteHabit(context);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 248, 90, 79),
                        ),
                        tooltip: "Delete the habit",
                      );
                    })
                  ],
                ),
              ),

              const SizedBox(height: 16.0,),

              Consumer<EditHabitPageViewModel>(
                  builder: (context, viewModel, child) {
                return InputSection(
                  title: "Habit Name",
                  description: "Enter the name of the habit you want to create.",
                  hintText: StringConstants.createHabitScreenNameHint,
                  controller: viewModel.titleController,
                  onChanged: viewModel.onTitleChanged,
                );
              }),
              const SizedBox(height: 16.0),
              Consumer<EditHabitPageViewModel>(
                  builder: (context, viewModel, child) {
                return InputSection(
                  title: "Habit Subject - Optional",
                  description: "Describe the subject of your habit.",
                  hintText: StringConstants.createHabitScreenSubjectHint,
                  controller: viewModel.subjectController,
                  onAutofillTap: viewModel.autoFillDescription,
                  descLoading: viewModel.descLoading,
                );
              }),
              const SizedBox(height: 24.0),
              Consumer<EditHabitPageViewModel>(
                  builder: (context, viewModel, child) {
                return ImageSelectionSection(
                  onPressed: () async {
                    viewModel.uploadImage();
                  },
                );
              }),
              const SizedBox(height: 16.0),
              Consumer<EditHabitPageViewModel>(
                  builder: (context, viewModel, child) {
                return GridView.builder(
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
                );
              }),
              const SizedBox(
                height: 24.0,
              ),
              Consumer<EditHabitPageViewModel>(
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
              }),
              const Spacer(),
              Expanded(
                child: Consumer<EditHabitPageViewModel>(
                  builder: (context, viewModel, child) {
                    return StadiumSideBlueButton(
                        onPressed: viewModel.saveHabit,
                        text: StringConstants.editHabitPageSaveButton);
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
