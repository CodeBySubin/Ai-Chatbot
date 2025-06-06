import 'package:flutter/material.dart';
import 'package:chatbot/Controller.dart/ChatController.dart';
import 'package:chatbot/Resource/Strings.dart';
import 'package:chatbot/Resource/colors.dart';
import 'package:chatbot/Screen/Widgets/prequestionWidget.dart';
import 'package:chatbot/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class Web extends StatelessWidget {
  final ChatController chatController;

  const Web({super.key, required this.chatController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.20,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/chatbot_logo.png',
                  color: colorPrimary,
                  width: 100,
                ),
                const Text(
                  Strings.appname,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Poppins-Regular',
                      color: colorPrimary),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    chatController.createToggle();
                    chatController.stopSpeaking();
                  },
                  child: Icon(
                    chatController.value ? Icons.volume_up : Icons.volume_off,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
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
                                          height: 90),
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
                                    color: chat.isSender
                                        ? colorPrimary
                                        : colorgrey,
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
                          padding: EdgeInsets.only(top: 10, bottom: 20),
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
                        cursorColor: Colors.grey,
                        focusNode: chatController.focusNode,
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
                              borderSide: const BorderSide(color: colorgrey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: colorgrey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: colorgrey),
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
                                  },
                                ),
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
                        },
                      ),
                    ),
                  ),
                ),
              ),
          chatController.chatHistory.isEmpty
                                ? Container()
                                :    Positioned(
                top: 5,
                right: 5,
                child: InkWell(
                  onTap: () {
                    chatController.scrollController.animateTo(
                      0.0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/image/export.svg",
                    color: Colors.black,
                    width: 30,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
