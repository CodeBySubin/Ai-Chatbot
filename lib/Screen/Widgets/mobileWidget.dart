import 'package:chatbot/Controller.dart/ChatController.dart';
import 'package:chatbot/Resource/Strings.dart';
import 'package:chatbot/Resource/colors.dart';
import 'package:chatbot/Screen/Widgets/prequestionWidget.dart';
import 'package:chatbot/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class Mobile extends StatelessWidget {
  final ChatController chatController;
  const Mobile({super.key, required this.chatController});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 40),
            child: chatController.chatHistory.isNotEmpty
                ? ListView.builder(
                    itemCount: chatController.chatHistory.length + 1,
                    controller: chatController.scrollController,
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == chatController.chatHistory.length) {
                        return chatController.chatstatus
                            ? Container(
                                child: Lottie.asset(
                                    'assets/image/loading_animation.json',
                                    height: 50),
                              )
                            : const SizedBox();
                      }
                      final chat = chatController.chatHistory[index];
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: chat.isSender
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0),
                                bottomRight: chat.isSender
                                    ? const Radius.circular(0.0)
                                    : const Radius.circular(20.0),
                                bottomLeft: chat.isSender
                                    ? const Radius.circular(20.0)
                                    : const Radius.circular(0.0),
                              ),
                              color: chat.isSender ? colorPrimary : colorgrey,
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              chat.message.replaceAll("*", ""),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins-Regular',
                                  color: chat.isSender
                                      ? Colors.white
                                      : const Color(0xFF656565)),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 0, bottom: 20),
                    child: QuestionItems(),
                  )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 226, 223, 223),
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0),
                  ),
                  BoxShadow(
                    color: Color.fromARGB(255, 226, 223, 223),
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(-2.0, -2.0),
                  ),
                  BoxShadow(
                    color: Color.fromARGB(255, 226, 223, 223),
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, -2.0),
                  ),
                  BoxShadow(
                    color: Color.fromARGB(255, 226, 223, 223),
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(-2.0, 2.0),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextFormField(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins-Regular',
                    ),
                    controller: chatController.chatController,
                    decoration: InputDecoration(
                        hintText: Strings.writeMessage,
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins-Regular',
                            color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 15.0,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: SvgPicture.asset(
                                chatController.isListening
                                    ? 'assets/image/mic.svg'
                                    : 'assets/image/micoff.svg',
                                color: colorPrimary,
                              ),
                              onPressed: () async {
                                if (chatController.chatstatus == false) {
                                  if (await chatController
                                          .speechToText.hasPermission &&
                                      chatController
                                          .speechToText.isNotListening) {
                                    await chatController.startListening();
                                  } else {
                                    chatController.sendMessage();
                                    chatController.initSpeechToText();
                                  }
                                }
                              },
                            ),
                            IconButton(
                                icon: Icon(
                                  chatController.chatstatus
                                      ? Icons.stop_circle
                                      : Icons.send,
                                  color: colorPrimary,
                                ),
                                onPressed: () {
                                  if (chatController.chatstatus == false) {
                                    if (chatController
                                        .chatController.text.isEmpty) {
                                      showSnackbar(Strings.enterMessage);
                                    } else {
                                      chatController.sendMessage();
                                    }
                                  }
                                }),
                          ],
                        )),
                    onFieldSubmitted: (value) {
                      if (chatController.chatstatus == false) {
                        if (chatController.chatController.text.isEmpty) {
                          showSnackbar(Strings.enterMessage);
                        } else {
                          chatController.sendMessage();
                        }
                      }
                    }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
