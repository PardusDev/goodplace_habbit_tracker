import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/services/api_service.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';
import '../constants/image_constants.dart';

class AIMessageStreamWidget extends StatefulWidget {
  Stream<String> messageStream;
  final ValueNotifier<bool> isStreamingNotifier;
  final Function(String) onMessageCompleted;
  final Function onMessagePartReceived;

  AIMessageStreamWidget(
      {required String message,
      required List<Map<String, dynamic>> conversationHistory,
      required this.isStreamingNotifier,
      required this.onMessageCompleted, required this.onMessagePartReceived})
      : messageStream =
            ApiService().goodplaceTChatStream(message, conversationHistory);

  @override
  _AIMessageStreamWidgetState createState() => _AIMessageStreamWidgetState();
}

class _AIMessageStreamWidgetState extends State<AIMessageStreamWidget>
    with SingleTickerProviderStateMixin {
  String displayedMessage = '';

  @override
  void initState() {
    super.initState();

    widget.messageStream.listen(
      (messagePart) {
        if (messagePart.isNotEmpty) {
          setState(() {
            displayedMessage += messagePart;
            widget.onMessagePartReceived();
          });
        }
      },
      onDone: () {
        widget.isStreamingNotifier.value = false;
        widget.onMessageCompleted(displayedMessage);
      },
      onError: (error) {
        widget.isStreamingNotifier.value = false;
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
          valueListenable: widget.isStreamingNotifier,
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
              child: RichText(
                text: TextSpan(
                  text: displayedMessage,
                  style: context.general.textTheme.titleMedium!.copyWith(
                    color: ColorConstants.aiChatBubbleTextColor,
                    fontWeight: FontWeight.w300,
                  ),
                  children: [
                    if (isLoading)
                      WidgetSpan(
                          child: Baseline(
                            baseline: context.general.textTheme.titleMedium!.fontSize! * 1.2,
                            baselineType: TextBaseline.alphabetic,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: ColorConstants.aiChatBubbleIndicatorGradientColors,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                      )
                  ]
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
