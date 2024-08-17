import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:goodplace_habbit_tracker/constants/string_constants.dart';
import 'package:goodplace_habbit_tracker/init/navigation/navigation_service.dart';
import 'package:goodplace_habbit_tracker/repository/repository.dart';
import 'package:goodplace_habbit_tracker/widgets/StadiumSideBlueButton.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';

class PrivacyPolicyCollapsableBottomSheet extends StatelessWidget {
  final String title;
  const PrivacyPolicyCollapsableBottomSheet({super.key, required this.title});

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
              child: FutureBuilder<String?>(
                future: Repository().getPrivacyPolicy(),
                builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${StringConstants.anErrorOccured}: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: HtmlWidget(
                        snapshot.data ?? '',
                      ),
                    );
                  } else {
                    return const Center(child: Text(StringConstants.anErrorOccured));
                  }
                },
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
