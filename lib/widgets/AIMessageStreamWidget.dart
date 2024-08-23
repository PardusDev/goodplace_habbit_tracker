import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';
import '../constants/image_constants.dart';

class AIMessageWidget extends StatefulWidget {
  final Stream<String> messageStream;
  final ValueNotifier<bool> isLoadingNotifier;

  AIMessageWidget({required this.messageStream, required this.isLoadingNotifier}) : super(key: UniqueKey());

  @override
  _AIMessageWidgetState createState() => _AIMessageWidgetState();
}

class _AIMessageWidgetState extends State<AIMessageWidget> with SingleTickerProviderStateMixin {
  String displayedMessage = '';

  @override
  void initState() {
    super.initState();

    widget.messageStream.listen((messagePart) {
      setState(() {
        displayedMessage += messagePart;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
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
        ValueListenableBuilder<bool>(
          valueListenable: widget.isLoadingNotifier,
          builder: (context, isLoading, child) {
            return Container(
              constraints: BoxConstraints(
                maxWidth: context.sized.dynamicWidth(0.75),
              ),
              padding: context.padding.low,
              decoration: BoxDecoration(
                color: ColorConstants.aiChatBubbleBackgroundColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                    displayedMessage,
                    style: context.general.textTheme.titleMedium!.copyWith(
                      color: ColorConstants.aiChatBubbleTextColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
            );
          },
        ),
        context.sized.emptySizedWidthBoxNormal,
      ],
    );
  }
}