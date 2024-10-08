import 'package:flutter/cupertino.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';
import 'package:goodplace_habbit_tracker/managers/AppUserManager.dart';
import 'package:goodplace_habbit_tracker/managers/HabitManager.dart';
import 'package:goodplace_habbit_tracker/widgets/AIMessageWidget.dart';
import 'package:goodplace_habbit_tracker/widgets/UserMessageWidget.dart';

import '../../constants/string_constants.dart';
import '../../models/UserHabit.dart';
import '../../widgets/AIMessageStreamWidget.dart';

class AiChatPageViewModel with ChangeNotifier, BaseViewModel {
  final AppUserManager _appUserManager = AppUserManager.instance;
  final HabitManager _habitManager = HabitManager();

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

  late final _appUser;
  get appUser => _appUser;

  AiChatPageViewModel(UserHabit? userHabit) {
    _appUser = _appUserManager.appUser;

    _initializeChat(userHabit);
    _initializePreparedChats(userHabit);
  }

  // region Initialize the chat
  void _initializeChat(UserHabit? userHabit) {
    StringBuffer habitsInfo = StringBuffer();

    for (var habit in _habitManager.habits) {
      habitsInfo.writeln(
        "- Habit Title: ${habit.title}, Subject or description: ${habit.subject}, Current Streak: ${habit.currentStreak.toString()} days, Max Streak: ${habit.maxStreak.toString()} days, Last Streak Update: ${habit.currentStreakLastDate.toString()}",
      );
    }

    if (userHabit == null) {
      _conversationHistory.add({
        "role": "system",
        "content": [
          {
            "type": "text",
            "text": "You are a conversational assistant named GoodPlaceT, part of the GoodPlace app. Your role is to provide information and guidance to users as they develop new habits. You can suggest new habits, offer motivation, and help users stay on track if they lose motivation. Always respond with concise answers, no longer than 40 words. If a user asks about topics unrelated to habits or motivation, respond with: 'I'm GoodPlaceT, your habit assistant. I can only assist with habits and motivation-related questions. Also, don't forget that the name of the person you're talking to is ${_appUser.name}. You can address them by their name when speaking."
                "The user's habits are as follows: ${habitsInfo.toString()}"
          }
        ]
      });

      _messages.add(
          AIMessageWidget(
              message: "Hello, ${_appUser.name}. I'm GoodPlaceT. How can I help you today?",
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
            "text": "You are a conversational assistant named GoodPlaceT, part of the GoodPlace app. You will engage in a discussion about a specific habit provided by the user. The details you have are as follows: Habit title is ${userHabit.title}, the subject is ${userHabit.subject}, the maximum streak achieved is ${userHabit.maxStreak} days, and the current streak is ${userHabit.currentStreak} days. You will only use this information to provide motivational and supportive responses. Your answers should always be concise, no longer than 40 words. If the user asks about topics unrelated to habits or motivation, respond with: 'I'm GoodPlaceT, your habit assistant. I can only assist with habits and motivation-related questions. Also, don't forget that the name of the person you're talking to is ${_appUser.name}. You can address them by their name when speaking."
                "Additionally, the user has the following habits as well. However, you don't need to talk about them. The habit you should focus on is the one I mentioned. ${habitsInfo.toString()}"
          }
        ]
      });

      _messages.add(
        AIMessageWidget(
          message: "Hello, ${_appUser.name}. Let's talk about your habit: ${userHabit.title}",
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
  // endregion

  // region Prepare some messages to prepared cards
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
  // endregion

  // region Add message to conversation history
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
  // endregion

  // region Add user message to widget list
  void addUserMessageToWidgetList(String message) {
    _messages.add(UserMessageWidget(message: message));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }
  // endregion
  
  Future<void> sendMessageToAI(String message) async {
    try {
      final isStreamingNotifier = ValueNotifier<bool>(true);
      _messages.add(
        AIMessageStreamWidget(
          message: message,
          conversationHistory: _conversationHistory,
          isStreamingNotifier: isStreamingNotifier,
          onMessageCompleted: (response) {
            // Add message to conversation history as assistant
            addMessageToConservationHistory(response, false);
          },
          onMessagePartReceived: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollToBottom();
            });
          }
        ),
      );
      notifyListeners();
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 1500));
      AIMessageStreamWidget lastMessage = _messages.last as AIMessageStreamWidget;
      lastMessage.messageStream = Stream.value(StringConstants.aiErrorMessage);
      lastMessage.isStreamingNotifier.value = false;
    }
  }

  Future<void> sendMessage() async {
    final userMessage = _messageController.text;
    var lastMessage = _messages.last;

    if (userMessage.isEmpty) {
      return;
    }

    // Check if the last message is still loading
    // This code will run only first time
    if (lastMessage == AIMessageWidget) {
      lastMessage = lastMessage as AIMessageWidget;
      if (lastMessage.isLoadingNotifier.value) {
        return;
      }
    }

    // Check if the last message is still streaming
    if (lastMessage == AIMessageStreamWidget) {
      lastMessage = lastMessage as AIMessageStreamWidget;
      if (lastMessage.isStreamingNotifier.value) {
        return;
      }
    }
    
    // Add user message to conversation history
    addUserMessageToWidgetList(userMessage);

    // Add message to conversation history
    // We dont need to add user message to conversation history
    // addMessageToConservationHistory(userMessage, true);
    
    _messageController.clear();
    
    // Send the message to the AI
    await sendMessageToAI(userMessage);

    notifyListeners();
  }

  Future<void> sendPreparedMessage(Map<String, dynamic> preparedMessage) async {
    var lastMessage = _messages.last;

    // Check if the last message is still loading
    // This code will run only first time
    if (lastMessage is AIMessageWidget) {
      lastMessage = lastMessage as AIMessageWidget;
      if (lastMessage.isLoadingNotifier.value) {
        return;
      }
    }

    // Check if the last message is still streaming
    if (lastMessage is AIMessageStreamWidget) {
      lastMessage = lastMessage as AIMessageStreamWidget;
      if (lastMessage.isStreamingNotifier.value) {
        return;
      }
    }

    // Widget
    addUserMessageToWidgetList(preparedMessage["title"]);

    // Add message to conversation history
    // We dont need to add user message to conversation history
    // addMessageToConservationHistory(preparedMessage["message"], true);

    // Send the message to the AI
    await sendMessageToAI(preparedMessage["message"]);

    notifyListeners();
  }

  void scrollToBottom() {
    if (_messagesListController.hasClients) {
      final position = _messagesListController.position.maxScrollExtent;
      _messagesListController.animateTo(
        position,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }
}