import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/widgets/CustomShimmer.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';
import '../constants/image_constants.dart';

@immutable
class MessageWidget extends StatelessWidget {
  String message;
  final bool isUser;
  final ValueNotifier<bool> isLoadingNotifier;
  MessageWidget({super.key, required this.message, required this.isUser, required this.isLoadingNotifier});

  @override
  Widget build(BuildContext context) {
    if (isUser) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.sized.emptySizedWidthBoxNormal,
          Expanded(
            child: Container(
              padding: context.padding.low,
              decoration: BoxDecoration(
                color: ColorConstants.aiChatBubbleUserBackgroundColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                message,
                style: context.general.textTheme.titleMedium!
                    .copyWith(
                    color: ColorConstants.aiChatBubbleUserTextColor,
                    fontWeight: FontWeight.w300
                ),
              ),
            ),
          ),
          context.sized.emptySizedWidthBoxLow3x,
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.asset(
              ImageConstants.userAvatar,
              width: 24,
              color: ColorConstants.primaryColor,
            ),
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.asset(
              ImageConstants.aiCreateIcon,
              width: 24,
              color: ColorConstants.primaryColor,
            ),
          ),
          context.sized.emptySizedWidthBoxLow3x,
          Expanded(
            child: ValueListenableBuilder<bool>(
              valueListenable: isLoadingNotifier,
              builder: (context, isLoading, child) {
                return Container(
                  padding: context.padding.low,
                  decoration: BoxDecoration(
                    color: ColorConstants.aiChatBubbleBackgroundColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: isLoading
                      ? Column(
                          children: [
                            const CustomShimmer(
                              height: 10,
                              width: double.infinity,
                            ),
                            context.sized.emptySizedHeightBoxLow,
                            const CustomShimmer(
                              height: 10,
                              width: double.infinity,
                            )
                          ],
                        )
                      : Text(
                          message,
                          style: context.general.textTheme.titleMedium!
                            .copyWith(
                              color: ColorConstants.aiChatBubbleTextColor,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                );
              }
            ),
          ),
          context.sized.emptySizedWidthBoxNormal,
        ],
      );
    }
  }
}
