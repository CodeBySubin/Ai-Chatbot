import 'package:chatbot/Resource/colors.dart';
import 'package:chatbot/Screen/Homepage.dart';
import 'package:chatbot/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    saveObject("introscreen", "seen");
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Your AI Assistant",
              style: TextStyle(
                  color: colorPrimary,
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.bold,
                  fontSize: 23)),
          const SizedBox(
            height: 40,
          ),
          const Text(
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 15),
              "Using this software,you can ask you\nquestions and receive articles using\nartificial intelligence assistant"),
          const SizedBox(
            height: 40,
          ),
          Center(child: Image.asset("assets/image/chat_image.png")),
        ],
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
            style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(colorPrimary),
            ),
            onPressed: () {
              Get.offAll(const HomePage());
            },
            child: const Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
      ),
    );
  }
}
