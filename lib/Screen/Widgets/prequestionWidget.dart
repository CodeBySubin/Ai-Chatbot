import 'package:chatbot/Controller.dart/ChatController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

void main() async {
  runApp(const MaterialApp(home: QuestionItems()));
}

class DataItem {
  final String svgImagePath;
  final List<String> strings;

  DataItem({
    required this.svgImagePath,
    required this.strings,
  });
}

class QuestionItems extends StatelessWidget {
  const QuestionItems({super.key});

  @override
  Widget build(BuildContext context) {
    List<DataItem> dataItems = [
      DataItem(
        svgImagePath: "assets/image/explane.svg",
        strings: [
          "Explain Quantum physics",
          "What are wormholes explain like i am 5",
        ],
      ),
      DataItem(
        svgImagePath: "assets/image/write_and_edit.svg",
        strings: [
          "Write a tweet about global warming",
          "Write a poem about flower and love",
          "Write a rap song lyrics about"
        ],
      ),
      DataItem(
        svgImagePath: "assets/image/transalate.svg",
        strings: [
          "How do you say “how are you” in korean?",
          "How do you say bonjour in English?",
          "How do you say “how are you” in korean?"
        ],
      ),
    ];

    return ListView.builder(
      itemCount: dataItems.length,
      itemBuilder: (context, index) {
        return Prequestion(dataItem: dataItems[index]);
      },
    );
  }
}

class Prequestion extends StatelessWidget {
  final DataItem dataItem;

  const Prequestion({
    super.key,
    required this.dataItem,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      initState: (_) {},
      builder: (controller) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SvgPicture.asset(
                dataItem.svgImagePath,
                height: 50,
                width: 50,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dataItem.strings.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () async {
                    controller.chatController.text = dataItem.strings[i];
                    if (await controller.speechToText.hasPermission &&
                        controller.speechToText.isNotListening) {
                      await controller.startListening();
                    } else {
                      controller.sendMessage();
                      controller.initSpeechToText();
                    }
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: Text(dataItem.strings[i]),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
