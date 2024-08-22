import 'package:flutter/cupertino.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';

import '../../widgets/MessageWidget.dart';

class AiChatPageViewModel with ChangeNotifier, BaseViewModel {
  final TextEditingController _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;

  final List<Widget> _messages = [
    const MessageWidget(
      message: "Hello, I'm GoodplaceT. How can I help you? Please write a message.",
      isUser: false,
    ),
  ];
  List<Widget> get messages => _messages;

  void sendMessage() {
    // Send message to AI
    _messages.add(
      MessageWidget(
        message: _messageController.text,
        isUser: true,
      ),
    );
    // API call to AI
    _messageController.clear();
    notifyListeners();
  }
}