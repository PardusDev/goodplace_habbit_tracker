import 'package:flutter/cupertino.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';
import 'package:goodplace_habbit_tracker/services/api_service.dart';

import '../../constants/string_constants.dart';
import '../../widgets/MessageWidget.dart';

class AiChatPageViewModel with ChangeNotifier, BaseViewModel {
  final ApiService _apiService = ApiService();
  
  final TextEditingController _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;

  final List<Widget> _messages = [
    const MessageWidget(
      message: StringConstants.aiWelcomeMessage,
      isUser: false,
    ),
  ];
  List<Widget> get messages => _messages;

  final List<Map<String, dynamic>> _conversationHistory = [
    {
      "role": "system",
      "content": [
        {
          "type": "text",
          "text": "You are a conversational assistant named GoodPlaceT, part of the GoodPlace app. Your role is to provide information and guidance to users as they develop new habits. You can suggest new habits, offer motivation, and help users stay on track if they lose motivation. Always respond with concise answers, no longer than 40 words."
        }
      ]
    }
  ];
  
  void addMessageToConservationHistory(String message, bool isUser) {
    // Widget. Maybe we can delete this
    _messages.add(
      MessageWidget(
        message: message,
        isUser: isUser,
      ),
    );

    // Add message to conversation history
    _conversationHistory.add({
      "role": isUser ? "user" : "assistant",
      "content": [
        {
          "type": "text",
          "text": message,
        }
      ]
    });
  }
  
  Future<void> sendMessageToAI(String message) async {
    try {
      final aiResponse = await _apiService.goodplaceTChat(message, _conversationHistory);

      addMessageToConservationHistory(aiResponse, false);

      notifyListeners();
    } catch (e) {
      _messages.add(
        const MessageWidget(
          message: StringConstants.aiErrorMessage,
          isUser: false,
        ),
      );
    }
  }

  Future<void> sendMessage() async {
    final userMessage = _messageController.text;

    if (userMessage.isEmpty) {
      return;
    }
    
    // Add user message to conversation history
    addMessageToConservationHistory(userMessage, true);
    
    _messageController.clear();
    notifyListeners();
    
    // Send the message to the AI
    await sendMessageToAI(userMessage);
    notifyListeners();
  }
}