import 'dart:io';
import 'package:chatbot/Utils/utils.dart';
import 'package:chatbot/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:file_picker/file_picker.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class ChatController extends GetxController {
  final TextEditingController chatController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var chatHistory = <ChatModel>[].obs;
  String? file;
  late Box<ChatModel> chatBox;
  final flutterTts = FlutterTts();
  late final GenerativeModel model;
  late final GenerativeModel visionModel;
  late final ChatSession chat;
  final SpeechToText speechToText = SpeechToText();
  bool isListening = false;
  String lastWords = '';

  Future<void> initSpeechToText() async {
    await speechToText.initialize(
      onError: (error) => showSnackbar(error.toString()),
      onStatus: (status) {
        if (status == 'done') {
          print("done");
          sendMessage();
        }
      },
    );
  }

  Future<void> startListening() async {
    await speechToText.listen(
      onResult: onSpeechResult,
      listenFor: const Duration(seconds: 5),
    );
  }

  Future<void> stopListening() async {
    await speechToText.stop();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    lastWords = result.recognizedWords;
    chatController.text = lastWords;
    update();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    update();
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.setVoice({
       'rate': '0.8', // Adjusted speech rate for a deliberate, measured pace
      'pitch': '1.2', // Higher pitch for a more feminine sound
      'volume': '1.0', // Full volume level
      'name': 'en-IN-Standard-A', // Voice name or language code (Indian English female voice)
      'locale': 'en-IN', // Language locale (for Indian English)
    });
    await flutterTts.speak(content);
  }

  @override
  void onClose() {
    speechToText.stop();
    chatController.dispose();
    scrollController.dispose();
    flutterTts.stop();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    initSpeechToText();
    initTextToSpeech();
    model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: 'AIzaSyA5WsZn0bhGR5hHmDMshhBtU2_Itw5FBRY',
    );
    visionModel = GenerativeModel(
      model: 'gemini-pro-vision',
      apiKey: 'AIzaSyA5WsZn0bhGR5hHmDMshhBtU2_Itw5FBRY',
    );
    chat = model.startChat();
    Hive.openBox<ChatModel>('chatBox').then((box) {
      chatBox = box;
      chatHistory.addAll(box.values);
      update();
    });
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      file = result.files.first.path;
      update();
    }
  }

  void sendMessage() async {
    if (chatController.text.isNotEmpty) {
      if (file != null) {
        final chatModel = ChatModel(
          DateTime.now().toString(),
          file!,
          true,
          true,
        );
        chatHistory.add(chatModel);
        chatBox.add(chatModel);
        file = null;
      } else {
        final chatModel = ChatModel(
          DateTime.now().toString(),
          chatController.text,
          false,
          true,
        );
        chatHistory.add(chatModel);
        chatBox.add(chatModel);
      }
      update();
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
      if (chatController.text.isNotEmpty) {
        await getAnswer(chatController.text);
        chatController.clear();
      }
    }
  }

  Future<void> getAnswer(String text) async {
    try {
      late final GenerateContentResponse response;
      var content = Content.text(text.toString());
      response = await chat.sendMessage(content);
      if (response.text != null && response.text!.isNotEmpty) {
        final chatModel = ChatModel(
          DateTime.now().toString(),
          response.text.toString(),
          false,
          false,
        );
        await systemSpeak(response.text.toString());
        chatHistory.add(chatModel);
        chatBox.add(chatModel);
        update();
        chatController.clear();
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      } else {
        print("AI did not return any text.");
      }
    } catch (e) {
      print("Error sending message: $e");
    }
  }
}
