import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:chatbot/Controller.dart/ChatController.dart';
import 'package:chatbot/Resource/colors.dart';
import 'package:chatbot/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  static const routeName = '/chat';

  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
Navigator.pushNamed(context, '/home');
          },
          child: const Icon(
            Icons.arrow_back,
            color: colorPrimary,
          ),
        ),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "BOB",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins-Regular',
              color: colorPrimary),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/image/chatbot_icon.png",
                width: 50, height: 50),
          ),
        ],
      ),
      body: GetBuilder<ChatController>(
        init: ChatController(),
        initState: (_) {},
        builder: (chatController) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: chatController.chatHistory.length,
                shrinkWrap: false,
                controller: chatController.scrollController,
                padding: const EdgeInsets.only(top: 10, bottom: 80),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final chat = chatController.chatHistory[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: chat.isSender
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  chat.isSender ? Colors.white : colorPrimary),
                          borderRadius: BorderRadius.circular(20),
                          color: chat.isSender ? colorPrimary : Colors.white,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          chat.message,
                          style: TextStyle(
                            fontSize: 15,
                            color: chat.isSender ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: TextFormField(
                  controller: chatController.chatController,
                  decoration: InputDecoration(
                    hintText: "Type a message",
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: colorPrimary)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: colorPrimary)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: colorPrimary)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: colorPrimary)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: Icon(
                              chatController.speechToText.isListening
                                  ? Icons.stop
                                  : Icons.mic,
                              color: colorPrimary,
                            ),
                            onPressed: () async {
                              if (await chatController
                                      .speechToText.hasPermission &&
                                  chatController.speechToText.isNotListening) {
                                await chatController.startListening();
                              } else {
                                chatController.initSpeechToText();
                              }
                            }),
                        IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: colorPrimary,
                          ),
                          onPressed: () {
                            if (chatController.chatController.text.isEmpty) {
                              showSnackbar("Please enter a message");
                            } else {
                              chatController.sendMessage();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 80,
                right: 12,
                child: AvatarGlow(
                  animate: chatController.isSpeaking,
                  startDelay: const Duration(milliseconds: 1000),
                  glowColor: colorPrimary,
                  duration: const Duration(milliseconds: 2000),
                  repeat: true,
                  curve: Curves.fastOutSlowIn,
                  child: const Material(
                    elevation: 0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: colorPrimary,
                      radius: 20.0,
                      child: Icon(
                        Icons.volume_up,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
