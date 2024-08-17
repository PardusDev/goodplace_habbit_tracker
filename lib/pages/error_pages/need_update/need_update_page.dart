import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/widgets/OutlinedButtonWithImage.dart';
import 'package:goodplace_habbit_tracker/widgets/Snackbars.dart';
import 'package:kartal/kartal.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/image_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../enums/platform_enum.dart';

class NeedUpdatePage extends StatelessWidget {
  const NeedUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    String imagePath = PlatformEnum.currentPlatform.storeImage;

    return Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        body: Center(
          child: Padding(
            padding: context.padding.medium,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(ImageConstants.updateRequiredVector),
                Text(StringConstants.needUpdate, style: context.general.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),),
                context.sized.emptySizedHeightBoxLow3x,
                Text(StringConstants.needUpdateSub, style: context.general.textTheme.titleMedium,),
                const Spacer(),
                OutlinedButtonWithImage(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        warningSnackBar(StringConstants.updateButtonDummy),
                      );
                    },
                    text: StringConstants.update,
                    imagePath: imagePath
                ),
                const Spacer()
              ],
            ),
          ),
        )
    );
  }
}
