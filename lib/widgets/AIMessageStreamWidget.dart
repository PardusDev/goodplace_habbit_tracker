import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';
import '../constants/image_constants.dart';
import 'CustomShimmer.dart';

class AIMessageStreamWidget extends StatefulWidget {
  Stream<String> messageStream;
  final ValueNotifier<bool> isLoadingNotifier;

  AIMessageStreamWidget({required this.messageStream, required this.isLoadingNotifier}) : super(key: UniqueKey());

  @override
  _AIMessageStreamWidgetState createState() => _AIMessageStreamWidgetState();
}

class _AIMessageStreamWidgetState extends State<AIMessageStreamWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String displayedMessage = '';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
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

    widget.messageStream.listen(
          (messagePart) {
        if (messagePart.isNotEmpty) {
          setState(() {
            displayedMessage += messagePart;
          });
        }
      },
      onError: (error) {
        print("Stream Error: $error");
      },
    );
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
                  displayedMessage,
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