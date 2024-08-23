import 'package:flutter/cupertino.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';
import 'package:goodplace_habbit_tracker/services/api_service.dart';
import 'package:goodplace_habbit_tracker/widgets/AIMessageWidget.dart';
import 'package:goodplace_habbit_tracker/widgets/UserMessageWidget.dart';

import '../../constants/string_constants.dart';
import '../../models/UserHabit.dart';

class AiChatPageViewModel with ChangeNotifier, BaseViewModel {
  final ApiService _apiService = ApiService();
  
  final TextEditingController _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;

  final ScrollController _messagesListController = ScrollController();
  ScrollController get messagesListController => _messagesListController;

  final List<Widget> _messages = [];
  List<Widget> get messages => _messages;

  final List<Map<String, dynamic>> _conversationHistory = [];

  List<Map<String, dynamic>> _startMessages = [];
  List<Map<String, dynamic>> get startMessages => _startMessages;

  String _status = "";
  String get status => _status;

  AiChatPageViewModel(UserHabit? userHabit) {
    _initializeChat(userHabit);
    _initializePreparedChats(userHabit);
  }

  void _initializeChat(UserHabit? userHabit) {
    if (userHabit == null) {

      _conversationHistory.add({
        "role": "system",
        "content": [
          {
            "type": "text",
            "text": "You are a conversational assistant named GoodPlaceT, part of the GoodPlace app. Your role is to provide information and guidance to users as they develop new habits. You can suggest new habits, offer motivation, and help users stay on track if they lose motivation. Always respond with concise answers, no longer than 40 words."
          }
        ]
      });

      _messages.add(
          AIMessageWidget(
              message: StringConstants.aiWelcomeMessage,
              isLoadingNotifier: ValueNotifier<bool>(true)
          )
      );

      _status = "Habit Guide";
    } else {

      _conversationHistory.add({
        "role": "system",
        "content": [
          {
            "type": "text",
            "text": "You are a conversational assistant named GoodPlaceT, part of the GoodPlace app. You will engage in a discussion about a specific habit provided by the user. The details you have are as follows: Habit title is ${userHabit.title}, the subject is ${userHabit.subject}, the maximum streak achieved is ${userHabit.maxStreak} days, and the current streak is ${userHabit.currentStreak} days. You will only use this information to provide motivational and supportive responses. Your answers should always be concise, no longer than 40 words."
          }
        ]
      });

      _messages.add(
        AIMessageWidget(
          message: "Let's talk about your habit: ${userHabit.title}",
          isLoadingNotifier: ValueNotifier<bool>(true),
        ),
      );

      _status = "Focused on ${userHabit.title}";
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      AIMessageWidget lastMessage = _messages.last as AIMessageWidget;
      lastMessage.isLoadingNotifier.value = false;
    });
  }

  void _initializePreparedChats(UserHabit? userHabit) {
    if (userHabit == null) {
      _startMessages = [
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
    } else {
      _startMessages = [
        {
          "title": "Motivate me on ${userHabit.title}",
          "message": "I'm struggling to keep up with ${userHabit.title}. Can you motivate me?",
        },
        {
          "title": "Improve ${userHabit.title}",
          "message": "How can I improve my efforts on ${userHabit.title}?",
        },
        {
          "title": "Track my progress",
          "message": "Can you give me some feedback on my progress with ${userHabit.title}?",
        },
        {
          "title": "Streak tips for ${userHabit.title}",
          "message": "How can I maintain or improve my streak with ${userHabit.title}?",
        }
      ];
    }
  }

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
    if (isUser) {
      _messages.add(
        UserMessageWidget(message: message)
      );
    } else {
      _messages.add(
        AIMessageWidget(
          message: message,
          isLoadingNotifier: ValueNotifier<bool>(true)
        ),
      );
    }
    /*
    if (!isUser) {
      MessageWidget lastMessage = _messages.last as MessageWidget;
      lastMessage.isLoadingNotifier.value = false;
    }
     */
  }

  void addMessageToBatch(String message, bool isUser) {
    addMessageToConservationHistory(message, isUser);
    if (isUser) {
      addMessageToWidgetList(message, isUser);
    } else {
      // Edit the last message to show the AI response
      AIMessageWidget lastMessage = _messages.last as AIMessageWidget;
      lastMessage.message = message;
      lastMessage.isLoadingNotifier.value = false;
    }
  }
  
  Future<void> sendMessageToAI(String message) async {
    try {
      // Add message to widget list
      _messages.add(
        AIMessageWidget(
          message: "",
          isLoadingNotifier: ValueNotifier<bool>(true)
        ),
      );

      _apiService.goodplaceTChatStream(message, _conversationHistory);
      // final aiResponse = await _apiService.goodplaceTChat(message, _conversationHistory);


      // addMessageToBatch(aiResponse, false);

      notifyListeners();
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 1500));
      AIMessageWidget lastMessage = _messages.last as AIMessageWidget;
      lastMessage.message = StringConstants.aiErrorMessage;
      lastMessage.isLoadingNotifier.value = false;
    }
  }

  Future<void> sendMessage() async {
    final userMessage = _messageController.text;
    final lastMessage = _messages.last as AIMessageWidget;

    if (userMessage.isEmpty) {
      return;
    }

    if (lastMessage.isLoadingNotifier.value) {
      return;
    }

    // Scroll to the bottom of the list
    scrollToBottom();
    
    // Add user message to conversation history
    addMessageToBatch(userMessage, true);
    
    _messageController.clear();
    notifyListeners();
    
    // Send the message to the AI
    await sendMessageToAI(userMessage);
    notifyListeners();
  }

  Future<void> sendPreparedMessage(Map<String, dynamic> preparedMessage) async {
    final lastMessage = _messages.last as AIMessageWidget;

    if (lastMessage.isLoadingNotifier.value) {
      return;
    }

    // Scroll to the bottom of the list
    scrollToBottom();

    // Widget
    addMessageToWidgetList(preparedMessage["title"], true);

    // Add message to conversation history
    addMessageToConservationHistory(preparedMessage["message"], true);

    notifyListeners();

    // Send the message to the AI
    await sendMessageToAI(preparedMessage["message"]);
    notifyListeners();
  }

  void scrollToBottom() {
    _messagesListController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}