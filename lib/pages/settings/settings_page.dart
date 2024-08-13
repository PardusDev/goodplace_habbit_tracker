import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/pages/settings/settings_page_view_model.dart';
import 'package:goodplace_habbit_tracker/widgets/ConfirmAlertDialog.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/icon_constants.dart';
import '../../constants/string_constants.dart';
import '../../widgets/BackButtonWithBorder.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsPageViewModel(),
      child: Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: context.padding.normal,
            child: Column(
              children: [
                //region Back Button
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Consumer<SettingsPageViewModel>(
                          builder: (context, viewModel, child) {
                            return BackButtonWithBorder(
                              onPressed: () {
                                viewModel.navigateToBack();
                              },
                            );
                          },
                        ),
                        context.sized.emptySizedWidthBoxLow3x,
                        Text(
                          StringConstants.settingsScreenTitle,
                          style: context.general.textTheme.headlineMedium!.copyWith(
                            color: ColorConstants.secondaryColor,
                          ),
                        ),
                      ],
                    )
                  ),
                ),
                //endregion Back Button End

                Expanded(
                  flex: 8,
                  child: Consumer<SettingsPageViewModel>(
                    builder: (context, viewModel, child) {
                      return ListView(
                        children: [
                          //region */*/*/* Delete Account */*/*/*
                          ListTile(
                            leading: const Icon(
                              IconConstants.deleteAccountIcon,
                              color: ColorConstants.deleteAccountButtonColor,
                            ),
                            title: Text(
                              StringConstants.deleteAccount,
                              style: context.general.textTheme.titleMedium!.copyWith(
                                color: ColorConstants.settingsScreenItemTextColor,
                              ),
                            ),
                            onTap: () async {
                              bool confirmed = await _showConfirmationDialog(context);
                              if (confirmed) {
                                viewModel.deleteAccount(context);
                              }
                            },
                          ),
                          //endregion */*/*/* Delete Account End */*/*/*

                          //region */*
                        ]
                      );
                    }
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const ConfirmAlertDialog(
            title: StringConstants.areYouSure,
            body: StringConstants.deleteAccountConfirmationText
        );
      },
    ) ?? false;
  }
}
