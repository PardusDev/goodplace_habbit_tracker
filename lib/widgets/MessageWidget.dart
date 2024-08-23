import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/widgets/CustomShimmer.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';
import '../constants/image_constants.dart';

class MessageWidget extends StatefulWidget {
  String message;
  final bool isUser;
  final ValueNotifier<bool> isLoadingNotifier;

  MessageWidget({
    required this.message,
    required this.isUser,
    required this.isLoadingNotifier,
  }) : super(key: UniqueKey());

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    if (!widget.isLoadingNotifier.value) {
      _animation = const AlwaysStoppedAnimation(1.0);
    }

    widget.isLoadingNotifier.addListener(() {
      if (!widget.isLoadingNotifier.value) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isUser) {
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
              widget.message,
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
    } else {
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
                    ),
                  ],
                )
                    : FadeTransition(
                  opacity: _controller.isCompleted ? const AlwaysStoppedAnimation(1.0) : _animation,
                  child: Text(
                    widget.message,
                    style: context.general.textTheme.titleMedium!.copyWith(
                      color: ColorConstants.aiChatBubbleTextColor,
                      fontWeight: FontWeight.w300,
                    ),
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
}