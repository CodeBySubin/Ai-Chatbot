import 'dart:async';
import 'package:chatbot/Screen/chatpage.dart';
import 'package:chatbot/Screen/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/Resource/colors.dart';
import 'package:chatbot/Utils/utils.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});
  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () async {
      var intro = await getSavedObject("introscreen");
      Navigator.of(context).pushReplacementNamed(
        intro == null ? IntroScreen.routeName : ChatPage.routeName,
      );
    });
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Center(child: Image.asset("assets/image/chatbot_logo.png")),
    );
  }
}
