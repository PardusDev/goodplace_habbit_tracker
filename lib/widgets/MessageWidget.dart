import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';
import '../constants/image_constants.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  final bool isUser;
  const MessageWidget({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    if (isUser) {
      return Row(
        children: [
          Expanded(
            child: Container(
              padding: context.padding.low,
              decoration: BoxDecoration(
                color: ColorConstants.aiChatBubbleBackgroundColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                message,
                style: context.general.textTheme.titleMedium!
                    .copyWith(
                    color: ColorConstants.aiChatBubbleTextColor,
                    fontWeight: FontWeight.w300
                ),
              ),
            ),
          ),
          context.sized.emptySizedWidthBoxLow3x,
          Image.asset(
            ImageConstants.aiAvatar,
            width: 24,
            color: ColorConstants.primaryColor,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Image.asset(
            ImageConstants.aiCreateIcon,
            width: 24,
            color: ColorConstants.primaryColor,
          ),
          context.sized.emptySizedWidthBoxLow3x,
          Expanded(
            child: Container(
              padding: context.padding.low,
              decoration: BoxDecoration(
                color: ColorConstants.aiChatBubbleBackgroundColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                message,
                style: context.general.textTheme.titleMedium!
                    .copyWith(
                    color: ColorConstants.aiChatBubbleTextColor,
                    fontWeight: FontWeight.w300
                ),
              ),
            ),
          )
        ],
      );
    }
  }
}
