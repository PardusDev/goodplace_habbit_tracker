import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/string_constants.dart';
import 'package:goodplace_habbit_tracker/init/navigation/navigation_service.dart';
import 'package:goodplace_habbit_tracker/widgets/StadiumSideBlueButton.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';

class CollapsableBottomSheet extends StatelessWidget {
  final String title;
  final String text;
  const CollapsableBottomSheet({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: context.padding.normal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: context.general.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.collapsableBottomSheetTitleColor
                ),
              ),
            ),
            
            Expanded(
              flex: 14,
              child: SingleChildScrollView(
                child: Text(
                  text,
                  style: context.general.textTheme.labelMedium!.copyWith(
                      color: ColorConstants.collapsableBottomSheetTextColor
                  ),
                ),
              ),
            ),

            const Spacer(),

            Expanded(
              child: StadiumSideBlueButton(
                  onPressed: () {
                    NavigationService.instance.navigateToBack();
                  },
                  text: StringConstants.collapsableBottomSheetClose
              ),
            ),
          ],
        ),
      ),
    );
  }
}
