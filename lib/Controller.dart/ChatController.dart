// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:file_picker/file_picker.dart';

// class ChatController extends GetxController {
//   final TextEditingController chatController = TextEditingController();
//   final ScrollController scrollController = ScrollController();
//   var chatHistory = <Map<String, dynamic>>[].obs;
//   String? file;

//   late final GenerativeModel model;
//   late final GenerativeModel visionModel;
//   late final ChatSession chat;

//   @override
//   void onInit() {
//     super.onInit();
//     model = GenerativeModel(
//       model: 'gemini-pro',
//       apiKey: 'AIzaSyBh7e4LEIHZxY6-uUXxHkhQ799Ufla5unw',
//     );
//     visionModel = GenerativeModel(
//       model: 'gemini-pro-vision',
//       apiKey: 'AIzaSyBh7e4LEIHZxY6-uUXxHkhQ799Ufla5unw',
//     );
//     chat = model.startChat();
//   }

//   @override
//   void onClose() {
//     chatController.dispose();
//     scrollController.dispose();
//     super.onClose();
//   }

//   void pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'jpeg', 'png'],
//     );
//     if (result != null) {
//       file = result.files.first.path;
//       update();
//     }
//   }

//   void sendMessage() async {
//     if (chatController.text.isNotEmpty) {
//       if (file != null) {
//         chatHistory.add({
//           "time": DateTime.now(),
//           "message": file,
//           "isSender": true,
//           "isImage": true,
//         });
//         file = null;
//       }

//       chatHistory.add({
//         "time": DateTime.now(),
//         "message": chatController.text,
//         "isSender": true,
//         "isImage": false,
//       });
//     }
//     scrollController.jumpTo(scrollController.position.maxScrollExtent);
//     update();
//     await getAnswer(chatController.text);
//     chatController.clear();
//   }

//   Future<void> getAnswer(String text) async {
//     try {
//       late final GenerateContentResponse response;
//       if (file != null) {
//         final firstImage = await (File(file!).readAsBytes());
//         final prompt = TextPart(text);
//         final imageParts = [DataPart('image/jpeg', firstImage)];
//         response = await visionModel.generateContent([
//           Content.multi([prompt, ...imageParts])
//         ]);
//         file = null;
//       } else {
//         var content = Content.text(text.toString());
//         response = await chat.sendMessage(content);
//       }

//       chatHistory.add({
//         "time": DateTime.now(),
//         "message": response.text,
//         "isSender": false,
//         "isImage": false,
//       });

//       scrollController.jumpTo(scrollController.position.maxScrollExtent);
//       update();
//     } catch (e) {
//       print("Error sending message: $e");
//     }
//   }

// }

import 'dart:io';
import 'package:chatbot/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:file_picker/file_picker.dart';

class ChatController extends GetxController {
  final TextEditingController chatController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var chatHistory = <ChatModel>[].obs;
  String? file;
  late Box<ChatModel> chatBox;

  late final GenerativeModel model;
  late final GenerativeModel visionModel;
  late final ChatSession chat;

  @override
  void onInit() {
    super.onInit();
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

  @override
  void onClose() {
    chatController.dispose();
    scrollController.dispose();
    super.onClose();
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
    print(chatController.text);
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
    print("answers");
    try {
      late final GenerateContentResponse response;
      if (file != null) {
        final firstImage = await (File(file!).readAsBytes());
        final prompt = TextPart(text);
        final imageParts = [DataPart('image/jpeg', firstImage)];
        response = await visionModel.generateContent([
          Content.multi([prompt, ...imageParts])
        ]);
        file = null;
      } else {
        var content = Content.text(text.toString());
        response = await chat.sendMessage(content);
      }
      if (response.text != null && response.text!.isNotEmpty) {
        final chatModel = ChatModel(
          DateTime.now().toString(),
          response.text.toString(),
          false,
          false,
        );
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
