import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/ai_chat/ai_chat_page_view_model.dart';
import 'package:goodplace_habbit_tracker/widgets/AIMessageWidget.dart';
import 'package:goodplace_habbit_tracker/widgets/OneLineInputField.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../models/UserHabit.dart';
import '../../widgets/AIMessageStreamWidget.dart';
import '../../widgets/SortCard.dart';
import '../../widgets/StadiumSideBlueIconButton.dart';
import '../../widgets/UserMessageWidget.dart';

class AiChatPage extends StatefulWidget {
  final UserHabit? userHabit;
  const AiChatPage({super.key, this.userHabit});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AiChatPageViewModel(widget.userHabit),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 60.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),

                const SizedBox(height: 16.0),

                Padding(
                  padding: context.padding.normal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringConstants.aiName,
                        style: context.general.textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.collapsableBottomSheetTitleColor
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Consumer<AiChatPageViewModel>(
                        builder: (context, viewModel, child) {
                          return Text(
                            viewModel.status,
                            style: context.general.textTheme.labelLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.secondaryColor
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ),

                context.sized.emptySizedHeightBoxLow,

                /*
                TODO: Deprecated
                Expanded(
                  child: Consumer<AiChatPageViewModel>(
                    builder: (context, viewModel, child) {
                      return ListView.separated(
                        controller: viewModel.messagesListController,
                        padding: EdgeInsets.zero,
                        reverse: false,
                        separatorBuilder: (context, index) => context.sized.emptySizedHeightBoxLow,
                        itemCount: viewModel.messages.length,
                        itemBuilder: (context, index) {
                          return viewModel.messages[index];
                        },
                      );
                    }
                  ),
                ),
                 */

                Expanded(
                  child: Consumer<AiChatPageViewModel>(
                      builder: (context, viewModel, child) {
                        return SingleChildScrollView(
                          controller: viewModel.messagesListController,
                          child: Padding(
                            padding: context.padding.normal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                for (var message in viewModel.messages)
                                  if (message is AIMessageStreamWidget || message is AIMessageWidget)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: message,
                                      ),
                                    )
                                  else if (message is UserMessageWidget)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: message,
                                      ),
                                    ),
                              ]
                            ),
                          ),
                        );
                      }
                  ),
                ),

                context.sized.emptySizedHeightBoxLow,

                SizedBox(
                  height: 40,
                  child: Consumer<AiChatPageViewModel>(
                    builder: (context, viewModel, child) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.startMessages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SortCard(
                                text: viewModel.startMessages[index]["title"],
                                onPressed: () {
                                  viewModel.sendPreparedMessage(viewModel.startMessages[index]);
                                }
                            ),
                          );
                        },
                      );
                    }
                  ),
                ),

                context.sized.emptySizedHeightBoxLow,

                Padding(
                  padding: context.padding.normal,
                  child: Consumer<AiChatPageViewModel>(
                    builder: (context, viewModel, child) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: OneLineInputField(
                              hintText: 'Write a message',
                              controller: viewModel.messageController,
                            ),
                          ),
                          context.sized.emptySizedWidthBoxLow3x,
                          Expanded(
                            child: StadiumSideBlueIconButton(
                                onPressed: () {
                                  viewModel.sendMessage();
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                )
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
