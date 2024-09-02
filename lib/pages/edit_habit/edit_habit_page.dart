import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/widgets/BackButtonWithBorder.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/string_constants.dart';
import '../../models/UserHabit.dart';
import '../../widgets/CheckboxWithWidget.dart';
import '../../widgets/CustomShimmer.dart';
import '../../widgets/InputSection.dart';
import '../../widgets/SelectableImageCard.dart';
import '../../widgets/StadiumSideBlueButton.dart';
import '../../widgets/TappableWidget.dart';
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
          padding: context.padding.horizontalNormal,
          child: SafeArea(
            child: Consumer<EditHabitPageViewModel>(
              builder: (context, viewModel, child) {
                return SingleChildScrollView(
                  controller: viewModel.scrollController,
                  padding: EdgeInsets.only(top: 14),
                  child: Column(
                    children: [
                      Row(
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
                      const SizedBox(height: 12.0),
                      // region Remind Me
                      Consumer<EditHabitPageViewModel>(
                        builder: (context, viewModel, child) {
                          return Column(
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
                                          '${viewModel.selectedTime?.hour.toString().padLeft(2, '0')}:${viewModel.selectedTime?.minute.toString().padLeft(2, '0')}',
                                          style: context.general.textTheme.headlineMedium!.copyWith(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold
                                          )
                                      )
                                    ],
                                  )
                              ),
                            ],
                          );
                        }
                      ),
                      // endregion
                      const SizedBox(height: 20.0),
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
                      context.sized.emptySizedHeightBoxLow3x,
                      Consumer<EditHabitPageViewModel>(
                        builder: (context, viewModel, child) {
                          return StadiumSideBlueButton(
                              onPressed: viewModel.saveHabit,
                              text: StringConstants.editHabitPageSaveButton);
                        }
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
