import 'package:chatbot/Utils/utils.dart';
import 'package:chatbot/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class ChatController extends GetxController {
  final TextEditingController chatController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var chatHistory = <ChatModel>[].obs;
  late Box<ChatModel> chatBox;
  final flutterTts = FlutterTts();
  final FocusNode focusNode = FocusNode();
  late final GenerativeModel model;
  late final GenerativeModel visionModel;
  late final ChatSession chat;
  final SpeechToText speechToText = SpeechToText();
  bool isListening = false;
  bool isSpeaking = false;
  bool chatstatus = false;
  bool value = true;
  String lastWords = '';

  @override
  void onInit() {
    super.onInit();
    initSpeechToText();
    initTextToSpeech();
    flutterTts.setCompletionHandler(() {
      isSpeaking = false;
      update();
    });
    model = GenerativeModel(
      model: 'gemini-pro',
      apiKey:"AIzaSyA5WsZn0bhGR5hHmDMshhBtU2_Itw5FBRY",
    );
    visionModel = GenerativeModel(
      model: 'gemini-pro-vision',
      apiKey:"AIzaSyA5WsZn0bhGR5hHmDMshhBtU2_Itw5FBRY",
    );
    chat = model.startChat();
    Hive.openBox<ChatModel>('chatBox').then((box) {
      chatBox = box;
      chatHistory.addAll(box.values);
      update();
    });
  }

  void createToggle() {
    value = !value;
    update();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize(
      options: [SpeechToText.webDoNotAggregate],
      onError: (error) => showSnackbar(error.toString()),
      onStatus: (status) {
        if (status == 'done') {
          isListening = false;
          update();
          sendMessage();
        }
      },
    );
  }

  Future<void> startListening() async {
    if (!isListening) {
      isListening = true;
      await speechToText.listen(
        onResult: onSpeechResult,
        listenFor: const Duration(seconds: 5),
      );
      update();
    }
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    chatController.text = result.recognizedWords;
  }

  Future<void> stopListening() async {
    if (isListening) {
      isListening = false;
      await speechToText.stop();
      update();
    }
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    update();
  }

  Future<void> systemSpeak(String content) async {
    isSpeaking = true;
    flutterTts.setSpeechRate(1.0);
    flutterTts.setPitch(1.0);
    flutterTts.setVolume(1.0);
    flutterTts.setVoice({'name': 'en-US-Wavenet-D', 'locale': 'en-US'});
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    speechToText.stop();
    chatController.dispose();
    scrollController.dispose();
    flutterTts.stop();
    super.onClose();
  }

  Future<void> stopSpeaking() async {
    if (isSpeaking) {
      await flutterTts.stop();
      isSpeaking = false;
      update();
    }
  }

  void sendMessage() async {
    stopSpeaking();
    if (chatController.text.isNotEmpty) {
      chatstatus = true;
      String messageText = chatController.text;
      chatController.clear();
      update();
      final chatModel = ChatModel(
        DateTime.now().toString(),
        messageText,
        false,
        true,
      );
      chatHistory.add(chatModel);
      chatBox.add(chatModel);
      update();
      await getAnswer(messageText);
    }
  }

  Future<void> getAnswer(String text) async {
    try {
      late final GenerateContentResponse response;
      var content = Content.text(text);
      response = await chat.sendMessage(content);
      if (response.text != null && response.text!.isNotEmpty) {
        chatstatus = false;
        final chatModel = ChatModel(
          DateTime.now().toString(),
          response.text.toString(),
          false,
          false,
        );
        if (value) {
          await systemSpeak(
              response.text.toString().replaceAll(RegExp(r'[*@`()]'), ''));
        }
        chatHistory.add(chatModel);
        chatBox.add(chatModel);
        update();
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      } else {
        showSnackbar("AI did not return any text.");
        chatstatus = false;
        update();
      }
    } catch (e) {
      showSnackbar(e.toString());
      chatstatus = false;
      update();
    }
  }
}
