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

  final List<Map<String, dynamic>> _startMessages = [
    {
      "title": "I need motivation",
      "message": "I'm losing motivation, can you help me get back on track?",
    },
    {
      "title": "Suggest a habit",
      "message": "Can you suggest a new habit for me to try?",
    },
    {
      "title": "Habit tips",
      "message": "Do you have any tips for maintaining my habits?",
    },
    {
      "title": "Boost my focus",
      "message": "I'm having trouble focusing on my habits. How can I improve?",
    }
  ];
  List<Map<String, dynamic>> get startMessages => _startMessages;

  void addMessageToConservationHistory(String message, bool isUser) {
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

  void addMessageToWidgetList(String message, bool isUser) {
    // Widget
    _messages.add(
      MessageWidget(
        message: message,
        isUser: isUser,
      ),
    );
  }

  void addMessageToBatch(String message, bool isUser) {
    addMessageToConservationHistory(message, isUser);
    addMessageToWidgetList(message, isUser);
  }
  
  Future<void> sendMessageToAI(String message) async {
    try {
      final aiResponse = await _apiService.goodplaceTChat(message, _conversationHistory);

      addMessageToBatch(aiResponse, false);

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
    addMessageToBatch(userMessage, true);
    
    _messageController.clear();
    notifyListeners();
    
    // Send the message to the AI
    await sendMessageToAI(userMessage);
    notifyListeners();
  }

  Future<void> sendPreparedMessage(Map<String, dynamic> preparedMessage) async {
    // Widget
    addMessageToWidgetList(preparedMessage["title"], true);

    // Add message to conversation history
    addMessageToConservationHistory(preparedMessage["message"], true);

    notifyListeners();

    // Send the message to the AI
    await sendMessageToAI(preparedMessage["message"]);
    notifyListeners();
  }
}