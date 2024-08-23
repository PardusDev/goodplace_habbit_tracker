
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:goodplace_habbit_tracker/core/exceptions/handle_dio_exception.dart';

class ApiService {
  String path = "https://api.quotable.io";
  String aiPath = "https://patrons-openai.openai.azure.com/openai/deployments/GrowTogether/chat/completions?api-version=2024-02-15-preview";
  String apiKey = '9070bb36762b4ddc8552f51b98091334';

  getMotivation() async {
    try {
      var response = await Dio().get('$path/random', queryParameters: {'tags': 'happiness'});
      return response.data['content'];
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      throw e;
    }
  }

  Future<String?> getPrivacyPolicy() async {
    try {
      var response = await Dio().get('https://pardev.one/goodplace-privacy-policy.json');
      return response.data['privacy'];
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      throw e;
    }
    return null;
  }


  Future<String> autoFillDescription(String title) async {
    try {
      Map<String, String> headers = {
        'api-key': apiKey,
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> data = {
        "messages": [
          {
            "role": "system",
            "content": [
              {
                "type": "text",
                "text": "You are a habit assistant and your name is GoodPlaceT. When a user wants to create a habit, they will give you a topic related to that habit and you will give them a short text explaining and motivating that habit. This text should not have a title and should be a short motivational text about the habit."
              }
            ]
          },
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text": title,
              }
            ]
          }
        ],
        "temperature": 0.7,
        "top_p": 0.95,
        "max_tokens": 800
      };

      var response = await Dio().post(
        aiPath,
        data: data,
        options: Options(
          headers: headers,
        ),
      );

      final messageContent = response.data['choices'][0]['message']['content'];
      return messageContent;
    } on DioException catch (e) {
      handleDioException(e);
      throw Exception("An error occurred during the API call.");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }

  Future<String> goodplaceTChat(String lastMessage, List<Map<String, dynamic>> conversationHistory) async {
    try {
      Map<String, String> headers = {
        'api-key': apiKey,
        'Content-Type': 'application/json',
      };

      // Add the new user message to the conversation history
      conversationHistory.add({
        "role": "user",
        "content": [
          {
            "type": "text",
            "text": lastMessage,
          }
        ]
      });

      Map<String, dynamic> data = {
        "messages": conversationHistory,
        "temperature": 0.7,
        "top_p": 0.95,
        "max_tokens": 800
      };

      var response = await Dio().post(
        aiPath,
        data: data,
        options: Options(
          headers: headers,
        ),
      );

      final messageContent = response.data['choices'][0]['message']['content'];
      return messageContent;
    } on DioException catch (e) {
      handleDioException(e);
      throw Exception("An error occurred during the API call.");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }

  Stream<String>? goodplaceTChatStream(String lastMessage, List<Map<String, dynamic>> conversationHistory) async* {
    final controller = StreamController<String>();

    try {
      Map<String, String> headers = {
        'api-key': apiKey,
        'Content-Type': 'application/json',
      };

      // Add the new user message to the conversation history
      conversationHistory.add({
        "role": "user",
        "content": [
          {
            "type": "text",
            "text": lastMessage,
          }
        ]
      });

      Map<String, dynamic> data = {
        "messages": conversationHistory,
        "temperature": 0.7,
        "top_p": 0.95,
        "max_tokens": 800,
        "stream": true
      };

      var response = await Dio().post(
        aiPath,
        data: data,
        options: Options(
          headers: headers,
          responseType: ResponseType.stream,
        ),
      );

      response.data.stream.listen((chunk) {
        final messageContent = utf8.decode(chunk);
        print(messageContent);
        final jsonResponse = json.decode(messageContent);
        print(jsonResponse);

        if (jsonResponse['choices'] != null && jsonResponse['choices'].isNotEmpty) {
          final content = jsonResponse['choices'][0]['message']['content'];
          print (content);
        }
      }, onDone: () {
        controller.close();
      });
    } on DioException catch (e) {
      controller.addError("An error occurred during the API call: $e");
      controller.close();
    } catch (e) {
      controller.addError("An error occurred: ${e.toString()}");
      controller.close();
    }

    yield* controller.stream;
  }
}