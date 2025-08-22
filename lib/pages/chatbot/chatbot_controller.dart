import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'models/message.dart';

class ChatbotController extends GetxController {
  var messages = <Message>[].obs;

  void addUserMessage(String text) {
    messages.add(Message(text: text, sender: Sender.user));
    addBotResponse(text);
  }

  final TextEditingController textController = TextEditingController();

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;
    addUserMessage(text);
    textController.clear();
  }

  Future<void> addBotResponse(String userText) async {
    messages.add(Message(text: "답변을 불러오는 중...", sender: Sender.bot));

    try {
      final url = Uri.parse(dotenv.env['CHAT_BOT_SERVER_URL']!);

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question": userText}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botReply = data["answer"] ?? "응답 없음";

        // 마지막 메시지를 교체
        messages[messages.length - 1] =
            Message(text: botReply, sender: Sender.bot);
      } else {
        messages[messages.length - 1] =
            Message(text: "에러: ${response.statusCode}", sender: Sender.bot);
      }
    } catch (e) {
      messages[messages.length - 1] =
          Message(text: "요청 실패: $e", sender: Sender.bot);
    }
  }
}
