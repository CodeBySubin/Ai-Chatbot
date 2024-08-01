import 'package:chatbot/Controller.dart/ChatController.dart';
import 'package:chatbot/Resource/Strings.dart';
import 'package:chatbot/Resource/colors.dart';
import 'package:chatbot/Screen/Widgets/MobileWidget.dart';
import 'package:chatbot/Screen/Widgets/prequestionWidget.dart';
import 'package:chatbot/Screen/Widgets/webWidget.dart';
import 'package:chatbot/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ChatPage extends StatelessWidget {
  static const routeName = '/chat';

  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      initState: (_) {},
      builder: (chatController) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (chatController.scrollController.offset !=
              chatController.scrollController.position.maxScrollExtent) {
            if (chatController.scrollController.hasClients) {
              chatController.scrollController.jumpTo(
                chatController.scrollController.position.maxScrollExtent,
              );
            }
          }
          chatController.focusNode.requestFocus();
        });
        return Scaffold(
            appBar: MediaQuery.of(context).size.width < 600
                ? AppBar(
                    surfaceTintColor: Colors.transparent,
                    leading: null,
                    // leading: InkWell(
                    //   onTap: () {
                    //     Navigator.pushNamed(context, '/home');
                    //   },
                    //   child: const Icon(
                    //     Icons.arrow_back_ios,
                    //     color: colorPrimary,
                    //   ),
                    // ),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                    title: Row(
                      children: [
                        Image.asset(
                          'assets/image/chatbot_logo.png',
                          color: colorPrimary,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          Strings.appname,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'Poppins-Regular',
                              color: colorPrimary),
                        ),
                      ],
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                chatController.createToggle();
                                chatController.stopSpeaking();
                              },
                              child: Icon(
                                chatController.value
                                    ? Icons.volume_up
                                    : Icons.volume_off,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            chatController.chatHistory.isEmpty
                                ? Container()
                                : InkWell(
                                    onTap: () {
                                      chatController.scrollController.animateTo(
                                        0.0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      "assets/image/export.svg",
                                      color: Colors.black,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  )
                : null,
            body: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                // Mobile UI
                return Mobile(
                  chatController: chatController,
                );
              } else {
                //Web ui
                return Web(
                  chatController: chatController,
                );
              }
            }));
      },
    );
  }
}
