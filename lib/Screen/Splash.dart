
import 'dart:async';
import 'package:chatbot/Screen/chatpage.dart';
import 'package:chatbot/Screen/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/Resource/colors.dart';
import 'package:chatbot/Utils/utils.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static const routeName = '/splash';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 5), () async {
      var intro = await getSavedObject("introscreen");

      if (!mounted) return; // prevents context use if widget is disposed
      Navigator.of(context).pushReplacementNamed(
        intro == null ? IntroScreen.routeName : ChatPage.routeName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Center(
        child: Image.asset("assets/image/chatbot_logo.png"),
      ),
    );
  }
}
