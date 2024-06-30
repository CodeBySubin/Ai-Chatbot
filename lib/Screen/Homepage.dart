import 'dart:io';

import 'package:chatbot/Controller.dart/ChatController.dart';
import 'package:chatbot/Resource/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<ChatController>(
        init: ChatController(),
        builder: (chatController) {
          return Container(
            padding: const EdgeInsets.only(top: 50, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: colorPrimary),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0, left: 16.0),
                              child: Text(
                                "Hi! You Can Ask Me",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Poppins-Regular',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Text(
                                "Anything",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 16.0, bottom: 16.0),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/chat');
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    "Ask Now",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 16.0),
                  child: Text(
                    "Recent Chats",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                chatController.chatHistory.isEmpty
                    ? Column(
                        children: [
                          Image.asset(
                            'assets/image/no_data.jpg',
                            height:
                                screenSize.height * 0.4, // 40% of screen height
                            width:
                                screenSize.width * 0.8, // 80% of screen width
                          ),
                          const Text(
                            "No Recent Chat Found",
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 20.0,
                              fontFamily: 'Poppins-Bold',
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: chatController.chatHistory.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                                            color: chat.isSender
                                                ? Colors.white
                                                : colorPrimary),
                                        borderRadius: BorderRadius.circular(20),
                                        color: chat.isSender
                                            ? colorPrimary
                                            : Colors.white,
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: chat.isImage
                                          ? Image.file(File(chat.message),
                                              width: 200)
                                          : Text(
                                              chat.message,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: chat.isSender
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                    )));
                          },
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
