import 'dart:async';

import 'package:chatbot/Screen/Homepage.dart';
import 'package:chatbot/Screen/intro_screen.dart';
import 'package:chatbot/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () async {
      var intro = await getSavedObject("introscreen");

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              intro==null ? IntroScreen() : HomePage()));
    });
    return Scaffold(
        body: Center(child: Lottie.asset('assets/image/bot_animation.json')));
  }
}
