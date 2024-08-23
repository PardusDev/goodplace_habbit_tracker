import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';
import '../constants/image_constants.dart';

class UserMessageWidget extends StatelessWidget {
  String message;
  UserMessageWidget({required this.message,}) : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.sized.emptySizedWidthBoxNormal,
        Container(
          constraints: BoxConstraints(
            maxWidth: context.sized.dynamicWidth(0.75),
          ),
          padding: context.padding.low,
          decoration: BoxDecoration(
            color: ColorConstants.aiChatBubbleUserBackgroundColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            message,
            style: context.general.textTheme.titleMedium!.copyWith(
              color: ColorConstants.aiChatBubbleUserTextColor,
              fontWeight: FontWeight.w300,
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
  }
}
